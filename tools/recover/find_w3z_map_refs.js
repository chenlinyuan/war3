#!/usr/bin/env node
"use strict";

const crypto = require("node:crypto");
const fs = require("node:fs");
const zlib = require("node:zlib");

function findAll(buffer, needle) {
    const found = [];
    let offset = 0;
    while ((offset = buffer.indexOf(needle, offset)) >= 0) {
        found.push(offset);
        offset++;
    }
    return found;
}

function context(buffer, offset, radius = 32) {
    const start = Math.max(0, offset - radius);
    const end = Math.min(buffer.length, offset + radius);
    return {
        hex: buffer.subarray(start, end).toString("hex"),
        ascii: buffer
            .subarray(start, end)
            .toString("latin1")
            .replace(/[\x00-\x1f\x7f-\xff]/g, "."),
    };
}

function main() {
    const [saveFile, ...mapFiles] = process.argv.slice(2);
    if (!saveFile || !mapFiles.length) {
        console.error(
            "usage: node find_w3z_map_refs.js SAVE UNCOMPRESSED_OR_W3Z MAP..."
        );
        process.exit(2);
    }

    const save = fs.readFileSync(saveFile);
    for (const mapFile of mapFiles) {
        const map = fs.readFileSync(mapFile);
        const crc = zlib.crc32(map) >>> 0;
        const hashes = {
            crc32le: Buffer.from([
                crc & 0xff,
                (crc >>> 8) & 0xff,
                (crc >>> 16) & 0xff,
                (crc >>> 24) & 0xff,
            ]),
            crc32be: Buffer.from([
                (crc >>> 24) & 0xff,
                (crc >>> 16) & 0xff,
                (crc >>> 8) & 0xff,
                crc & 0xff,
            ]),
            md5: crypto.createHash("md5").update(map).digest(),
            sha1: crypto.createHash("sha1").update(map).digest(),
            sha256: crypto.createHash("sha256").update(map).digest(),
        };

        const result = {
            mapFile,
            mapBytes: map.length,
            references: {},
        };
        for (const [name, needle] of Object.entries(hashes)) {
            const offsets = findAll(save, needle);
            result.references[name] = {
                value: needle.toString("hex"),
                offsets,
                contexts: offsets.slice(0, 5).map((offset) => ({
                    offset,
                    ...context(save, offset),
                })),
            };
        }
        console.log(JSON.stringify(result, null, 2));
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
