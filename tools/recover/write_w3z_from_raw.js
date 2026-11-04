"use strict";

const fs = require("node:fs");
const path = require("node:path");
const zlib = require("node:zlib");
const { parse } = require("./w3z_probe");

function fail(message) {
    throw new Error(message);
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

function main() {
    const [input, rawPath, output] = process.argv.slice(2);
    if (!input || !rawPath || !output) {
        fail("usage: write_w3z_from_raw.js INPUT.w3z RAW.bin OUTPUT.w3z");
    }
    const source = parse(input);
    const raw = fs.readFileSync(rawPath);
    if (raw.length !== source.uncompressed.length) {
        fail(
            `raw size ${raw.length} differs from save size ` +
            source.uncompressed.length
        );
    }

    const parts = [
        Buffer.from(source.archive.subarray(0, source.header.headerSize)),
    ];
    let offset = 0;
    for (const block of source.blocks) {
        const data = raw.subarray(offset, offset + block.uncompressedSize);
        const compressed = compressBlock(data);
        const inflated = zlib.inflateRawSync(compressed.subarray(2), {
            finishFlush: zlib.constants.Z_SYNC_FLUSH,
        });
        if (!inflated.equals(data)) {
            fail(`block ${block.index} compression check failed`);
        }
        const header = Buffer.alloc(12);
        header.writeUInt32LE(compressed.length, 0);
        header.writeUInt32LE(block.uncompressedSize, 4);
        header.writeUInt32LE(
            blockCRC(compressed, block.uncompressedSize),
            8
        );
        parts.push(header, compressed);
        offset += block.uncompressedSize;
    }
    const result = Buffer.concat(parts);
    result.writeUInt32LE(result.length, 0x20);
    result.writeUInt32LE(0, 0x40);
    result.writeUInt32LE(zlib.crc32(result.subarray(0, 0x44)) >>> 0, 0x40);
    fs.writeFileSync(output, result);

    const verification = parse(output);
    if (!verification.uncompressed.equals(raw)) {
        fail("written save does not inflate to the patched raw data");
    }
    console.log(JSON.stringify({
        input: path.resolve(input),
        raw: path.resolve(rawPath),
        output: path.resolve(output),
        blocks: verification.blocks.length,
        bytes: result.length,
    }, null, 2));
}

try {
    main();
} catch (error) {
    console.error(error.stack || error);
    process.exit(1);
}
