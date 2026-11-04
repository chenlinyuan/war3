#!/usr/bin/env bash
#
# Fetch and build unluac into tools/unluac (git-ignored).
#
# unluac is MIT licensed: https://github.com/HansWessels/unluac
#
# Usage: scripts/get-unluac.sh
#
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dest="$root/tools/unluac"
repo="https://github.com/HansWessels/unluac.git"

if [ -d "$dest/src/build/unluac" ]; then
    echo "unluac already built in $dest/src/build"
    exit 0
fi

command -v git >/dev/null 2>&1 || { echo "error: git is required" >&2; exit 1; }
command -v javac >/dev/null 2>&1 || { echo "error: a JDK is required (javac not found)" >&2; exit 1; }

mkdir -p "$root/tools"
if [ ! -d "$dest/.git" ]; then
    echo "cloning unluac ..."
    git clone --depth 1 "$repo" "$dest"
fi

echo "compiling ..."
mkdir -p "$dest/src/build"
(
    cd "$dest/src"
    # shellcheck disable=SC2046
    javac -nowarn -d build $(find unluac -name '*.java')
)

echo
echo "done: $dest/src/build"
echo "luac53 will find it automatically; or set UNLUAC_JAR to a jar."
