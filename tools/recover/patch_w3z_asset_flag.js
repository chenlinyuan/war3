"use strict";

const fs = require("node:fs");
const zlib = require("node:zlib");
const { parse } = require("./w3z_probe");

const BLOCK_SIZE = 1 << 20;

function fail(message) {
    throw new Error(message);
}

function equal(left, right) {
    return left.length === right.length && left.every((value, index) => value === right[index]);
}

function decodeSettings(encoded) {
    const decoded = [];
    let mask = 0;
    for (let index = 0; index < encoded.length; index++) {
        if (index % 8 === 0) {
            mask = encoded[index];
        } else {
            decoded.push(mask & (1 << (index % 8)) ? encoded[index] : encoded[index] - 1);
        }
    }
    return Buffer.from(decoded);
}

function encodeSettings(decoded) {
    const output = [];
    for (let offset = 0; offset < decoded.length; offset += 7) {
        let mask = 1;
        const group = Array.from(decoded.subarray(offset, offset + 7));
        for (let index = 0; index < group.length; index++) {
            if (group[index] & 1) {
                mask |= 1 << (index + 1);
            } else {
                group[index]++;
            }
        }
        output.push(mask, ...group);
    }
    return Buffer.from(output);
}

function identity(raw) {
    const mapEnd = raw.indexOf(0);
    if (mapEnd < 0) {
        fail("save map name is not terminated");
    }
    const map = raw.subarray(0, mapEnd).toString("ascii");
    let start = -1;
    let end = -1;
    let decoded = null;

    for (let index = map.length + 3; index < Math.min(raw.length, 512) && start < 0; index++) {
        if (raw[index - 1] !== 0 || raw[index - 2] !== 0 || raw[index] === 0) {
            continue;
        }
        const stop = raw.indexOf(0, index);
        if (stop < 0 || stop - index < 16) {
            continue;
        }
        const encoded = raw.subarray(index, stop);
        const candidate = decodeSettings(encoded);
        if (candidate.length < 14 || !equal(encodeSettings(candidate), encoded)) {
            continue;
        }
        const nameEnd = candidate.indexOf(0, 13);
        if (nameEnd < 0) {
            continue;
        }
        const name = candidate.subarray(13, nameEnd).toString("ascii");
        if (name.toLowerCase().replaceAll("\\", "/") !== map.toLowerCase().replaceAll("\\", "/")) {
            continue;
        }
        start = index;
        end = stop;
        decoded = candidate;
    }

    if (start < 0) {
        fail("save settings record not found");
    }
    const slotStart = end + 9;
    if (slotStart + 3 > raw.length) {
        fail("save player-slot record is missing");
    }
    const slotSize = raw.readUInt16LE(slotStart);
    const slots = raw[slotStart + 2];
    if (slots > 24 || slotSize !== 1 + slots * 9 + 6) {
        fail("unsupported save player-slot layout");
    }
    return {
        map,
        checksum: decoded.subarray(9, 13),
        plainOffset: slotStart + 2 + slotSize + 4,
    };
}

function assetFlag(raw, info) {
    const limit = Math.min(raw.length - 8, info.plainOffset + 4 + 64);
    for (let offset = info.plainOffset + 4; offset < limit; offset++) {
        if (raw.readUInt32LE(offset) !== 1 ||
            raw[offset + 4] < 32 ||
            raw[offset + 4] > 126) {
            continue;
        }
        let end = offset + 4;
        while (end < raw.length && end < offset + 4 + 64 &&
            raw[end] >= 32 && raw[end] < 127) {
            end++;
        }
        if (raw[end] !== 0 || end + 5 > raw.length) {
            return null;
        }
        return {
            offset: end + 1,
            value: raw.readUInt32LE(end + 1),
        };
    }
    return null;
}

function compressBlock(data) {
    const raw = zlib.deflateRawSync(data, {
        level: 1,
        finishFlush: zlib.constants.Z_SYNC_FLUSH,
    });
    return Buffer.concat([Buffer.from([0x78, 0x01]), raw]);
}

function blockCRC(compressed, expandedSize) {
    const header = Buffer.alloc(12);
    header.writeUInt32LE(compressed.length, 0);
    header.writeUInt32LE(expandedSize, 4);
    const fold = (value) => ((value ^ (value >>> 16)) & 0xffff) >>> 0;
    return (fold(zlib.crc32(header)) |
        (fold(zlib.crc32(compressed)) << 16)) >>> 0;
}

function rebuild(source, firstBlock) {
    const blocks = [];
    for (let index = 0; index < source.blocks.length; index++) {
        const block = source.blocks[index];
        let compressed;
        if (index === 0) {
            compressed = compressBlock(firstBlock);
            const inflated = zlib.inflateRawSync(compressed.subarray(2), {
                finishFlush: zlib.constants.Z_SYNC_FLUSH,
            });
            if (!inflated.equals(firstBlock)) {
                fail("recompressed first block did not round-trip");
            }
        } else {
            const start = block.offset + 12;
            compressed = source.archive.subarray(start, start + block.compressedSize);
        }
        blocks.push({
            compressed,
            uncompressedSize: block.uncompressedSize,
            checksum: blockCRC(compressed, block.uncompressedSize),
        });
    }

    const header = Buffer.from(
        source.archive.subarray(0, source.header.headerSize)
    );
    const parts = [header];
    for (const block of blocks) {
        const blockHeader = Buffer.alloc(12);
        blockHeader.writeUInt32LE(block.compressed.length, 0);
        blockHeader.writeUInt32LE(block.uncompressedSize, 4);
        blockHeader.writeUInt32LE(block.checksum, 8);
        parts.push(blockHeader, block.compressed);
    }
    const output = Buffer.concat(parts);
    output.writeUInt32LE(output.length, 0x20);
    output.writeUInt32LE(0, 0x40);
    output.writeUInt32LE(zlib.crc32(output.subarray(0, 0x44)) >>> 0, 0x40);
    return output;
}

function main() {
    const [input, output, oldValueArg, newValueArg] = process.argv.slice(2);
    if (!input || !output || oldValueArg === undefined || newValueArg === undefined) {
        console.error(
            "usage: node patch_w3z_asset_flag.js INPUT.w3z OUTPUT.w3z OLD NEW"
        );
        process.exit(2);
    }
    const oldValue = Number(oldValueArg);
    const newValue = Number(newValueArg);
    if (!Number.isInteger(oldValue) || !Number.isInteger(newValue)) {
        fail("asset flags must be integers");
    }

    const source = parse(input);
    if (source.header.headerVersion !== 1 || source.blocks[0].uncompressedSize !== BLOCK_SIZE) {
        fail("unsupported save header or first-block size");
    }
    const first = Buffer.from(
        source.uncompressed.subarray(0, source.blocks[0].uncompressedSize)
    );
    const info = identity(first);
    const flag = assetFlag(first, info);
    if (!flag) {
        fail("player header asset flag was not found");
    }
    if (flag.value !== oldValue) {
        fail(`expected asset flag ${oldValue}, found ${flag.value}`);
    }
    first.writeUInt32LE(newValue, flag.offset);

    const outputData = rebuild(source, first);
    fs.writeFileSync(output, outputData);

    const verification = parse(output);
    const verifiedFirst = verification.uncompressed.subarray(
        0,
        verification.blocks[0].uncompressedSize
    );
    const verifiedInfo = identity(verifiedFirst);
    const verifiedFlag = assetFlag(verifiedFirst, verifiedInfo);
    if (!verifiedFlag || verifiedFlag.value !== newValue) {
        fail("output asset flag verification failed");
    }
    if (!verifiedInfo.checksum.equals(info.checksum)) {
        fail("output map checksum changed");
    }
    for (let index = 1; index < source.blocks.length; index++) {
        const start = index * source.blocks[index].uncompressedSize;
        const end = start + source.blocks[index].uncompressedSize;
        if (!verification.uncompressed.subarray(start, end).equals(
            source.uncompressed.subarray(start, end)
        )) {
            fail(`output block ${index} changed`);
        }
    }
    if (!verification.archive.subarray(48, 64).equals(source.archive.subarray(48, 64))) {
        fail("save build or duration changed");
    }

    console.log(JSON.stringify({
        input: require("node:path").resolve(input),
        output: require("node:path").resolve(output),
        map: info.map,
        checksum: info.checksum.toString("hex"),
        flagOffset: flag.offset,
        oldFlag: oldValue,
        newFlag: newValue,
        inputBytes: source.archive.length,
        outputBytes: outputData.length,
    }, null, 2));
}

if (require.main === module) {
    try {
        main();
    } catch (error) {
        console.error(error.stack || error);
        process.exit(1);
    }
}
