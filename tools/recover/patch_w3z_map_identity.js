#!/usr/bin/env node
"use strict";

// Rewrites only a save's map identity: the encoded map checksum, its two
// plain checksum references, and the two map SHA-1 references. Saved Lua is
// intentionally left untouched.

const fs = require("node:fs");
const path = require("node:path");
const zlib = require("node:zlib");
const { parse } = require("./w3z_probe");

function fail(message) {
    throw new Error(message);
}

function equal(left, right) {
    return left.length === right.length &&
        left.every((value, index) => value === right[index]);
}

function decodeSettings(encoded) {
    const decoded = [];
    let mask = 0;
    for (let index = 0; index < encoded.length; index++) {
        if (index % 8 === 0) {
            mask = encoded[index];
        } else {
            decoded.push(
                mask & (1 << (index % 8)) ? encoded[index] : encoded[index] - 1
            );
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

function findAll(buffer, needle) {
    const found = [];
    let offset = 0;
    while ((offset = buffer.indexOf(needle, offset)) >= 0) {
        found.push(offset);
        offset++;
    }
    return found;
}

function saveIdentity(raw) {
    const mapEnd = raw.indexOf(0);
    if (mapEnd < 0) {
        fail("save map name is not terminated");
    }
    const map = raw.subarray(0, mapEnd).toString("ascii");

    for (let start = map.length + 3;
        start < Math.min(raw.length, 512);
        start++) {
        if (raw[start - 1] !== 0 ||
            raw[start - 2] !== 0 ||
            raw[start] === 0) {
            continue;
        }
        const end = raw.indexOf(0, start);
        if (end < 0 || end - start < 36) {
            continue;
        }
        const encoded = raw.subarray(start, end);
        const decoded = decodeSettings(encoded);
        if (decoded.length < 33 ||
            !equal(encodeSettings(decoded), encoded)) {
            continue;
        }
        const nameEnd = decoded.indexOf(0, 13);
        if (nameEnd < 0) {
            continue;
        }
        const name = decoded.subarray(13, nameEnd).toString("ascii");
        if (name.toLowerCase().replaceAll("\\", "/") !==
            map.toLowerCase().replaceAll("\\", "/")) {
            continue;
        }
        return {
            map,
            start,
            end,
            decoded,
            checksum: decoded.subarray(9, 13),
            sha1: decoded.subarray(decoded.length - 20),
        };
    }
    fail("save settings record not found");
}

function blockStart(blocks, index) {
    let start = 0;
    for (let current = 0; current < index; current++) {
        start += blocks[current].uncompressedSize;
    }
    return start;
}

function blockForOffset(blocks, offset, length) {
    for (const block of blocks) {
        const start = blockStart(blocks, block.index);
        const end = start + block.uncompressedSize;
        if (offset >= start && offset + length <= end) {
            return block;
        }
    }
    fail(`no save block contains offset ${offset}`);
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
    return (
        fold(zlib.crc32(header)) |
        (fold(zlib.crc32(compressed)) << 16)
    ) >>> 0;
}

function rebuild(source, uncompressed, modifiedBlocks) {
    const parts = [Buffer.from(
        source.archive.subarray(0, source.header.headerSize)
    )];
    for (const block of source.blocks) {
        const start = blockStart(source.blocks, block.index);
        const end = start + block.uncompressedSize;
        let compressed;
        if (modifiedBlocks.has(block.index)) {
            const data = uncompressed.subarray(start, end);
            compressed = compressBlock(data);
            const roundTrip = zlib.inflateRawSync(compressed.subarray(2), {
                finishFlush: zlib.constants.Z_SYNC_FLUSH,
            });
            if (!roundTrip.equals(data)) {
                fail(`block ${block.index} compression check failed`);
            }
        } else {
            const dataOffset = block.offset + 12;
            compressed = source.archive.subarray(
                dataOffset,
                dataOffset + block.compressedSize
            );
        }
        const header = Buffer.alloc(12);
        header.writeUInt32LE(compressed.length, 0);
        header.writeUInt32LE(block.uncompressedSize, 4);
        header.writeUInt32LE(
            blockCRC(compressed, block.uncompressedSize),
            8
        );
        parts.push(header, compressed);
    }
    const output = Buffer.concat(parts);
    output.writeUInt32LE(output.length, 0x20);
    output.writeUInt32LE(0, 0x40);
    output.writeUInt32LE(zlib.crc32(output.subarray(0, 0x44)) >>> 0, 0x40);
    return output;
}

function hexBytes(value, label) {
    if (!/^[0-9a-f]+$/i.test(value) || value.length !== 8) {
        fail(`${label} must be four bytes of hexadecimal`);
    }
    return Buffer.from(value, "hex");
}

function sha1Bytes(value, label) {
    if (!/^[0-9a-f]{40}$/i.test(value)) {
        fail(`${label} must be a 40-character SHA-1 hex string`);
    }
    return Buffer.from(value, "hex");
}

function main() {
    const [input, output, checksumArg, sha1Arg] = process.argv.slice(2);
    if (!input || !output || !checksumArg || !sha1Arg) {
        console.error(
            "usage: node patch_w3z_map_identity.js " +
            "INPUT.w3z OUTPUT.w3z NEW_CHECKSUM_HEX NEW_SHA1_HEX"
        );
        process.exit(2);
    }
    if (path.resolve(input) === path.resolve(output)) {
        fail("output must differ from input");
    }

    const newChecksum = hexBytes(checksumArg, "NEW_CHECKSUM_HEX");
    const newSha1 = sha1Bytes(sha1Arg, "NEW_SHA1_HEX");
    const source = parse(input);
    if (source.header.headerVersion !== 1) {
        fail(`unsupported save header version ${source.header.headerVersion}`);
    }
    if (source.trailerSize !== 0) {
        fail(`unsupported ${source.trailerSize}-byte save trailer`);
    }

    const raw = Buffer.from(source.uncompressed);
    const identity = saveIdentity(raw);
    if (identity.decoded.length < 33) {
        fail("save settings record is too short");
    }

    // The encoded settings record is patched separately. There are two other
    // plain identity references: the statstring near the prefix and the saved
    // map metadata later in the stream. The old checksum can also occur by
    // chance inside the encoded settings bytes, so exclude that record.
    const checksumHits = findAll(raw, identity.checksum)
        .filter((offset) => offset < identity.start || offset >= identity.end);
    const mapName = Buffer.from(identity.map, "ascii");
    const namedChecksumPrefix = Buffer.from([1]);
    const namedChecksumSuffix = Buffer.from([0]);
    let prefixChecksumReferences = 0;
    for (const offset of checksumHits) {
        const followedBySha1 = raw.subarray(
            offset + identity.checksum.length,
            offset + identity.checksum.length + identity.sha1.length
        ).equals(identity.sha1);
        const followedByName = raw.subarray(
            offset + identity.checksum.length,
            offset + identity.checksum.length + mapName.length + 1
        ).equals(Buffer.concat([mapName, namedChecksumSuffix]));
        const followedByNamedLink = raw.subarray(
            offset + identity.checksum.length,
            offset + identity.checksum.length + mapName.length + 2
        ).equals(Buffer.concat([
            namedChecksumPrefix,
            mapName,
            namedChecksumSuffix,
        ]));
        if (followedBySha1) {
            prefixChecksumReferences++;
        } else if (!followedByName && !followedByNamedLink) {
            fail(`unrecognized plain map checksum reference at offset ${offset}`);
        }
    }
    if (prefixChecksumReferences !== 1 || checksumHits.length < 2) {
        fail(
            "expected one prefix map checksum reference and at least one " +
            "saved-map reference; found " + checksumHits.length
        );
    }
    const sha1Hits = findAll(raw, identity.sha1)
        .filter((offset) => offset < identity.start || offset >= identity.end);
    if (sha1Hits.length !== 2) {
        fail(
            "expected exactly two plain map SHA-1 references; found " +
            sha1Hits.length
        );
    }

    const updatedSettings = Buffer.from(identity.decoded);
    newChecksum.copy(updatedSettings, 9);
    const settingsSha1 = findAll(updatedSettings, identity.sha1);
    if (settingsSha1.length !== 1) {
        fail(
            "expected exactly one map SHA-1 in the settings record; found " +
            settingsSha1.length
        );
    }
    newSha1.copy(updatedSettings, settingsSha1[0]);
    const updatedEncoded = encodeSettings(updatedSettings);
    if (updatedEncoded.length !== identity.end - identity.start) {
        fail("encoded settings record changed length");
    }

    const patched = Buffer.from(raw);
    updatedEncoded.copy(patched, identity.start);
    for (const offset of checksumHits) {
        newChecksum.copy(patched, offset);
    }
    for (const offset of sha1Hits) {
        newSha1.copy(patched, offset);
    }

    const changedOffsets = [];
    for (let index = 0; index < raw.length; index++) {
        if (raw[index] !== patched[index]) {
            changedOffsets.push(index);
        }
    }
    const modifiedBlocks = new Set();
    for (const offset of changedOffsets) {
        modifiedBlocks.add(blockForOffset(source.blocks, offset, 1).index);
    }

    const outputData = rebuild(source, patched, modifiedBlocks);
    fs.writeFileSync(output, outputData);

    const verification = parse(output);
    if (!verification.uncompressed.equals(patched)) {
        fail("rebuilt save decompressed content differs");
    }
    for (const block of verification.blocks) {
        const dataOffset = block.offset + 12;
        const compressed = verification.archive.subarray(
            dataOffset,
            dataOffset + block.compressedSize
        );
        if (block.checksum !== blockCRC(compressed, block.uncompressedSize)) {
            fail(`rebuilt block ${block.index} checksum is invalid`);
        }
    }
    const verified = saveIdentity(verification.uncompressed);
    if (!verified.checksum.equals(newChecksum)) {
        fail("rebuilt save checksum verification failed");
    }
    if (!verified.sha1.equals(newSha1)) {
        fail("rebuilt save SHA-1 verification failed");
    }
    if (findAll(verification.uncompressed, newChecksum).length < 2) {
        fail("rebuilt save is missing the new checksum references");
    }
    if (findAll(verification.uncompressed, newSha1).length < 2) {
        fail("rebuilt save is missing the new SHA-1 references");
    }

    console.log(JSON.stringify({
        input: path.resolve(input),
        output: path.resolve(output),
        map: identity.map,
        oldChecksum: identity.checksum.toString("hex"),
        newChecksum: newChecksum.toString("hex"),
        oldSha1: identity.sha1.toString("hex"),
        newSha1: newSha1.toString("hex"),
        changedBytes: changedOffsets.length,
        rebuiltBlocks: [...modifiedBlocks].sort((a, b) => a - b),
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
