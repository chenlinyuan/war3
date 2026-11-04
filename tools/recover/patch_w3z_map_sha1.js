#!/usr/bin/env node
"use strict";

const fs = require("node:fs");
const zlib = require("node:zlib");
const { parse } = require("./w3z_probe");

function parseSha1(value, label) {
    if (!/^[0-9a-f]{40}$/i.test(value)) {
        throw new Error(`${label} must be a 40-character SHA-1 hex string`);
    }
    return Buffer.from(value, "hex");
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

function compressBlock(data) {
    const raw = zlib.deflateRawSync(data, {
        level: 1,
        finishFlush: zlib.constants.Z_SYNC_FLUSH,
    });
    return Buffer.concat([Buffer.from([0x78, 0x01]), raw]);
}

function rebuild(sourceResult, blocks) {
    const source = sourceResult.archive;
    const header = Buffer.from(source.subarray(0, sourceResult.header.headerSize));
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
    const [input, output, oldSha1Arg, newSha1Arg] = process.argv.slice(2);
    if (!input || !output || !oldSha1Arg || !newSha1Arg) {
        console.error(
            "usage: node patch_w3z_map_sha1.js " +
            "INPUT.w3z OUTPUT.w3z OLD_SHA1 NEW_SHA1"
        );
        process.exit(2);
    }

    const oldSha1 = parseSha1(oldSha1Arg, "OLD_SHA1");
    const newSha1 = parseSha1(newSha1Arg, "NEW_SHA1");
    const sourceResult = parse(input);
    if (sourceResult.header.headerVersion !== 1) {
        throw new Error(
            `unsupported save header version ${sourceResult.header.headerVersion}`
        );
    }
    if (sourceResult.trailerSize !== 0) {
        throw new Error(
            `unsupported ${sourceResult.trailerSize}-byte save trailer`
        );
    }

    const uncompressed = Buffer.from(sourceResult.uncompressed);
    const matches = findAll(uncompressed, oldSha1);
    if (matches.length !== 2) {
        throw new Error(
            `expected exactly two old map SHA-1 fields, found ${matches.length}`
        );
    }

    for (const offset of matches) {
        newSha1.copy(uncompressed, offset);
    }

    const modifiedBlocks = new Set(
        matches.map((offset) => {
            const block = sourceResult.blocks.find((candidate) => {
                const start = candidate.index * candidate.uncompressedSize;
                return offset >= start &&
                    offset + newSha1.length <= start + candidate.uncompressedSize;
            });
            if (!block) {
                throw new Error(`no save block contains SHA-1 offset ${offset}`);
            }
            return block.index;
        })
    );

    const blocks = [];
    for (const sourceBlock of sourceResult.blocks) {
        const start = sourceBlock.index * sourceBlock.uncompressedSize;
        const end = start + sourceBlock.uncompressedSize;
        const data = uncompressed.subarray(start, end);
        let compressed;
        if (modifiedBlocks.has(sourceBlock.index)) {
            compressed = compressBlock(data);
            const roundTrip = zlib.inflateRawSync(compressed.subarray(2), {
                finishFlush: zlib.constants.Z_SYNC_FLUSH,
            });
            if (!roundTrip.equals(data)) {
                throw new Error(
                    `block ${sourceBlock.index} compression check failed`
                );
            }
        } else {
            const dataOffset = sourceBlock.offset + 12;
            compressed = sourceResult.archive.subarray(
                dataOffset,
                dataOffset + sourceBlock.compressedSize
            );
        }
        blocks.push({
            compressed,
            uncompressedSize: sourceBlock.uncompressedSize,
            checksum: sourceBlock.checksum,
        });
    }

    const rebuilt = rebuild(sourceResult, blocks);
    fs.writeFileSync(output, rebuilt);

    const verification = parse(output);
    if (!verification.uncompressed.equals(uncompressed)) {
        throw new Error("rebuilt save decompressed content differs");
    }
    if (findAll(verification.uncompressed, newSha1).length !== 2) {
        throw new Error("rebuilt save is missing the new map SHA-1 fields");
    }
    if (findAll(verification.uncompressed, oldSha1).length !== 0) {
        throw new Error("rebuilt save still contains the old map SHA-1 fields");
    }

    console.log(JSON.stringify({
        input: require("node:path").resolve(input),
        output: require("node:path").resolve(output),
        oldSha1: oldSha1Arg.toLowerCase(),
        newSha1: newSha1Arg.toLowerCase(),
        patchedOffsets: matches,
        inputBytes: sourceResult.archive.length,
        outputBytes: rebuilt.length,
        uncompressedBytes: uncompressed.length,
        blocks: blocks.length,
        rebuiltBlocks: [...modifiedBlocks].sort((a, b) => a - b),
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
