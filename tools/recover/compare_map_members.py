#!/usr/bin/env python3
"""Compare members of two Warcraft III maps by size and SHA-1."""

import hashlib
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
INJECTOR = os.path.abspath(os.path.join(HERE, "..", "war3map-injector"))
sys.path.insert(0, INJECTOR)

import war3mpq  # noqa: E402


def main():
    left, right = sys.argv[1:3]
    archives = [war3mpq.MPQArchive(left), war3mpq.MPQArchive(right)]
    try:
        names = sorted(
            set(archives[0].files()) | set(archives[1].files()),
            key=str.lower,
        )
        for name in names:
            values = []
            for archive in archives:
                try:
                    data = archive.read_file(name)
                except Exception:
                    data = None
                values.append(
                    None
                    if data is None
                    else (len(data), hashlib.sha1(data).hexdigest())
                )
            if values[0] != values[1]:
                print(name)
                for path, value in zip((left, right), values):
                    if value is None:
                        print(" ", os.path.basename(path), "missing")
                    else:
                        print(
                            " ",
                            os.path.basename(path),
                            value[0],
                            value[1],
                        )
    finally:
        for archive in archives:
            archive.close()


if __name__ == "__main__":
    main()
