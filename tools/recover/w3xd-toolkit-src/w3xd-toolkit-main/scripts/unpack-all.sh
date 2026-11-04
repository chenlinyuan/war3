#!/usr/bin/env bash
#
# Unpack every .w3xd in a directory and decompile the Lua inside each map.
#
# Usage: scripts/unpack-all.sh <dir-with-.w3xd> [python]
#
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src="${1:?usage: unpack-all.sh <dir-with-.w3xd> [python]}"
py="${2:-python3}"

echo "== decrypting containers =="
PYTHONPATH="$root" "$py" -m w3xd batch "$src" -x

echo
echo "== decompiling war3map.luac =="
for d in "$src"/*.files; do
    [ -d "$d" ] || continue
    luac="$d/war3map.luac"
    [ -f "$luac" ] || continue
    PYTHONPATH="$root" "$py" -m luac53 decompile "$luac"
done

echo
echo "done.  Each <map>.files/ now holds war3map.lua next to war3map.luac."
