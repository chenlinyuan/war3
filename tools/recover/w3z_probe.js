#!/usr/bin/env node
"use strict";

const fs = require("node:fs");
const path = require("node:path");
const zlib = require("node:zlib");

const MAGIC = Buffer.from("Warcraft III recorded game\x1a", "binary");
const BLOCK_HEADER_VERSION_1 = 12;

function inflateBlock(data) {
    // 3.x save blocks use a two-byte zlib header and a sync-flushed raw
    // deflate body. The stream intentionally has no final deflate block.
    return zlib.inflateRawSync(data.subarray(2), {
        finishFlush: zlib.constants.Z_SYNC_FLUSH,
    });
}

function parse(file) {
    const archive = fs.readFileSync(file);
    if (!archive.subarray(0, MAGIC.length).equals(MAGIC)) {
        throw new Error("not a Warcraft III recorded-game/save file");
    }

    const headerSize = archive.readUInt32LE(0x1c);
    const headerVersion = archive.readUInt32LE(0x24);
    const blockCount = archive.readUInt32LE(0x2c);
    const blockHeaderSize = headerVersion === 1
        ? BLOCK_HEADER_VERSION_1
        : 8;
    const blocks = [];
    const chunks = [];
    let offset = headerSize;

    for (let index = 0; index < blockCount; index++) {
        if (offset + blockHeaderSize > archive.length) {
            throw new Error(`block ${index} header is past end of file`);
        }

        const compressedSize = blockHeaderSize === 12
            ? archive.readUInt32LE(offset)
            : archive.readUInt16LE(offset);
        const uncompressedSize = blockHeaderSize === 12
            ? archive.readUInt32LE(offset + 4)
            : archive.readUInt16LE(offset + 2);
        const checksum = blockHeaderSize === 12
            ? archive.readUInt32LE(offset + 8)
            : archive.readUInt32LE(offset + 4);
        const dataOffset = offset + blockHeaderSize;
        const dataEnd = dataOffset + compressedSize;
        if (dataEnd > archive.length) {
            throw new Error(`block ${index} data is past end of file`);
        }

        const compressed = archive.subarray(dataOffset, dataEnd);
        const uncompressed = inflateBlock(compressed);
        if (uncompressed.length !== uncompressedSize) {
            throw new Error(
                `block ${index} inflated to ${uncompressed.length}, ` +
                `expected ${uncompressedSize}`
            );
        }

        blocks.push({
            index,
            offset,
            compressedSize,
            uncompressedSize,
            checksum,
        });
        chunks.push(uncompressed);
        offset = dataEnd;
    }

    return {
        archive,
        header: {
            headerSize,
            compressedSize: archive.readUInt32LE(0x20),
            headerVersion,
            blockCount,
        },
        blocks,
        trailerOffset: offset,
        trailerSize: archive.length - offset,
        uncompressed: Buffer.concat(chunks),
    };
}

function readZeroString(buffer, offset, encoding = "utf8") {
    const end = buffer.indexOf(0, offset);
    if (end < 0) {
        return { value: "", next: buffer.length };
    }
    return {
        value: buffer.subarray(offset, end).toString(encoding),
        next: end + 1,
    };
}

function describe(result, file) {
    const data = result.uncompressed;
    const strings = [];
    let offset = 0;
    while (strings.length < 12 && offset < Math.min(data.length, 1024)) {
        const item = readZeroString(data, offset);
        if (!item.value) {
            break;
        }
        strings.push({ offset, value: item.value });
        offset = item.next;
    }

    return {
        file,
        archiveBytes: result.archive.length,
        header: result.header,
        trailerOffset: result.trailerOffset,
        trailerSize: result.trailerSize,
        compressedBytes: result.blocks.reduce(
            (total, block) => total + block.compressedSize,
            0
        ),
        uncompressedBytes: data.length,
        prefixStrings: strings,
        first256Hex: data.subarray(0, 256).toString("hex"),
    };
}

function main() {
    const args = process.argv.slice(2);
    if (!args.length) {
        console.error("usage: node w3z_probe.js [--dump DIR] SAVE.w3z [...]");
        process.exit(2);
    }

    let dumpDirectory = "";
    const files = [];
    for (let index = 0; index < args.length; index++) {
        if (args[index] === "--dump") {
            dumpDirectory = args[++index];
        } else {
            files.push(args[index]);
        }
    }

    if (dumpDirectory) {
        fs.mkdirSync(dumpDirectory, { recursive: true });
    }

    for (const file of files) {
        const result = parse(file);
        const summary = describe(result, path.resolve(file));
        if (dumpDirectory) {
            const output = path.join(
                dumpDirectory,
                `${path.basename(file)}.uncompressed.bin`
            );
            fs.writeFileSync(output, result.uncompressed);
            summary.dump = path.resolve(output);
        }
        console.log(JSON.stringify(summary, null, 2));
    }
}

if (require.main === module) {
    try {
        main();
    } catch (error) {
        console.error(error.stack || error);
        process.exit(1);
    }
}

module.exports = { inflateBlock, parse };
