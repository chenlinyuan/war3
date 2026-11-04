# Contributing to w3xd-toolkit

**English** · [简体中文](CONTRIBUTING.zh-CN.md)

Thanks for wanting to help. This document covers what is welcome, what is not,
and how to get a change merged.

---

## Contents

| | |
|---|---|
| [Ground rules](#ground-rules) | the three rules that are not negotiable |
| [What we need most](#what-we-need-most) | where help is actually useful |
| [Development setup](#development-setup) | clone, run, test |
| [Code style](#code-style) | how the code reads |
| [Adding a test for a format change](#adding-a-test-for-a-format-change) | the expected shape of a PR |
| [Reporting a format discrepancy](#reporting-a-format-discrepancy) | how to report *without* pasting game data |
| [Commits and pull requests](#commits-and-pull-requests) | branch, message, review |
| [Documentation](#documentation) | the bilingual README rule |

---

## Ground rules

These three are not stylistic preferences. A pull request that breaks one of
them cannot be merged, however good the code is.

### 1. Never commit game data, keys, or decompiled game content

This repository contains **no Blizzard content** and must stay that way. Do not
open a pull request containing:

* `.w3x`, `.w3m`, `.w3n`, `.w3xd`, `.mpq`, `.luac` files, or anything under a
  `*.files/` directory;
* extracted assets — models, textures, audio, terrain, string tables;
* **decompiled `war3map.lua` from a shipped map.** It is Blizzard's source, and
  committing it would make this repository a distribution point for it;
* a **license value or derived AES key**. Yours is account bound; publishing it
  lets anyone decrypt your containers. This includes pasting it into an issue;
* memory dumps, disassembly listings of large parts of the executable, or
  Blizzard binaries of any kind.

The `.gitignore` blocks the common extensions, but it is a backstop, not a
licence to try. If you are unsure whether something is safe to include, open an
issue describing it *in prose* first.

What you **can** always include: offsets, sizes, field layouts, short
instruction excerpts (a handful of lines, to make a point), algorithm
descriptions, and synthetic test data you generate yourself.

### 2. No new runtime dependencies

`w3xd-toolkit` installs with `pip install -e .` and pulls in **nothing**. AES,
CCM, the GF(2) solver and the MPQ reader are all implemented in-tree, and
Windows CNG is an optional accelerator rather than a requirement. A pull
request that adds a required third-party package will be asked to drop it;
optional extras under `[project.optional-dependencies]` are fine for
development tooling.

The one external tool the project uses, unluac, is fetched by a script at
runtime and is never vendored.

### 3. Every format-touching change needs an offline test

The test suite builds its own containers and MPQ archives and asserts against
them. A change to parsing, crypto or transcoding must come with a test in the
same style — one that runs on a clean checkout with no game files present.

A test that only passes when you happen to have a map on disk will be rejected,
and so will "I verified it manually". If you cannot express your case
synthetically, say so in the PR and we will work out how.

---

## What we need most

Roughly in order of usefulness:

1. **Corrections to the format documentation.** If a field is documented wrong
   or a detail is missing, that is the highest-value contribution there is.
   Bring evidence — an offset, a size, a short disassembly excerpt.
2. **Test vectors.** Synthetic coverage of edge cases the current suite misses:
   zero-length payloads, maximum header sizes, containers at the 0x6C boundary,
   MPQ archives with many sectors or unusual block shifts, Lua chunks with
   deeply nested prototypes.
3. **Portability.** Anything that breaks on a platform without `bcrypt.dll`, or
   on an older Python, or under a non-UTF-8 locale.
4. **Decompilation quality.** If unluac mis-renders a construct and you can
   show what the bytecode actually says, a documented workaround (like the
   `lua_patch.py` case that became `docs/luac-format.md`) is very welcome.
5. **Tooling and docs.** The CASC scanner described in the README is not
   included; a clean, dependency-free implementation of it would be a real
   addition.
6. **Performance.** Pure-Python AES on a 13 MB payload is the slow path. A
   better ISA-agnostic approach, or a faster xorshift inner loop, is welcome —
   as long as it does not change results.

Not wanted: reformatting-only pull requests, dependency bumps with no
behavioural reason, and adding features that make it easier to redistribute
game assets.

---

## Development setup

Python 3.8 or newer. Nothing else is required for the core work.

```bash
git clone https://github.com/mythic-p/w3xd-toolkit
cd w3xd-toolkit
python -m unittest discover -s tests -t .        # 53 tests, under a second
```

`pytest` also works if you prefer it (`pip install pytest && pytest`), but the
suite must keep running under plain `unittest` — that is the baseline.

To exercise the decompilation path you also need Java and unluac:

```bash
scripts/get-unluac.sh          # Linux/macOS
scripts\get-unluac.ps1         # Windows PowerShell
```

You do **not** need Warcraft III installed to develop or test anything in this
repository. If you want to check a change against real data, use your own copy
and keep the results out of the repository.

---

## Code style

There is no linter configuration to satisfy; the house style is what the
existing files do.

* **Docstrings explain why, not what.** `# read the size, then the data` is
  noise. The comments worth writing are the ones that record a non-obvious
  decision — why the hash table index is hash type 0, why the Adler-32 is
  ignored, why a length is one byte and sometimes nine.
* **Cite the evidence.** When code implements a reversed format, say where it
  came from: a module docstring naming the RVA, or a reference to the document
  in `docs/`.
* **Keep modules small and single-purpose.** `w3xd/xorshift.py` does one thing.
  Prefer adding a module to growing an existing one.
* **Fail loudly.** Wrong input raises (`W3xdError`, `LuaChunkError`); it does
  not return `None` to be discovered later.
* **No silent fallbacks that change results.** Falling back from CNG to pure
  Python is fine because both produce identical bytes. Falling back from "I do
  not understand this chunk" to "here is some output" is not.
* Line length around 90, four-space indent, snake_case, `from . import x`.
* Keep the public surface of each package in its `__all__`.

---

## Adding a test for a format change

The pattern to follow is in `tests/test_container.py` and `tests/test_mpq.py`:
build the thing, then assert you can read it back.

For a container, `w3xd.container.build()` produces a synthetic `.w3xd` around
arbitrary bytes for a chosen license:

```python
from w3xd.container import Container, build

raw = build(0x0123456789ABCDEF, fake_mpq())     # fake_mpq starts with MPQ\x1a
c = Container(raw)
assert c.license == 0x0123456789ABCDEF
assert c.decrypt_payload() == fake_mpq()
```

For an MPQ, `tests/test_mpq.py::build_mpq` lays out a header, a hash table, a
block table and sector data from scratch — extend it if you need more members
or a different sector size.

For bytecode, `luac53.chunk.ChunkWriter` writes both flavours, so a round trip
is:

```python
w = ChunkWriter(chunk.BLIZZARD)
w.byte(1)
w.write_function(my_proto)
data = bytes(w.out)
out, _ = chunk.convert(data)
_h, _n, main, _s = chunk.parse(out, chunk.STOCK)
assert main["consts"] == my_proto["consts"]
```

Two habits worth copying from the existing suite:

* **assert on the negative case too** — that random data raises, that a wrong
  key fails the tag, that a tampered payload is rejected. A parser that accepts
  everything passes a positive-only test suite.
* **assert the size arithmetic** — `hdr_size + payload_size + 0x40 == file size`
  is cheap and catches off-by-one errors in layout code.

---

## Reporting a format discrepancy

If you find that a documented field is wrong, an issue is as welcome as a pull
request. Please describe it so that it can be reproduced **without** anyone
copying game files:

* which document and which field;
* the actual offsets and sizes you observed;
* how you observed it (a few lines of disassembly, a hexdump of the field in
  question, or a synthetic reproduction);
* what you expected instead.

Do **not** attach a map, an extracted file, or a decompiled script. If the
evidence is a value from your own container, describe its *role and size*, not
the value itself — for the license in particular, never paste it.

---

## Commits and pull requests

* Branch from `main`; name it for the change (`fix/trailer-size-check`,
  `docs/mpq-locale-field`).
* One logical change per pull request. Formatting fixes and behaviour changes do
  not belong in the same commit.
* Commit messages: a short imperative subject, then a body explaining *why* if
  it is not obvious. `Fix off-by-one in the sector offset table check` beats
  `fix bug`.
* In the pull request, say what you changed and how you know it is right. If it
  touches the format, link the document you updated.
* Expect review to ask for evidence. This project's whole value is that its
  claims are checkable, so "it works on my machine" is not enough — a test or a
  citation is.

A pull request is ready when `python -m unittest discover -s tests -t .` passes
on a clean checkout, the change is covered by a test, and the documentation
still matches the code.

---

## Documentation

The README exists in two languages:

| file | language |
|---|---|
| `README.md` | English (default) |
| `README.zh-CN.md` | Simplified Chinese |

**If you change one, change the other**, and keep the language switcher on line
3 of each intact. The same applies to `CONTRIBUTING.md` and
`CONTRIBUTING.zh-CN.md`.

The reference documents under `docs/` are English only; a translation is
welcome but not required, and an out-of-date translation is worse than none.

When you land a format change, update the matching document in `docs/` in the
same pull request. `docs/reverse-engineering.md` also keeps a list of
approaches that did not work — adding to it saves the next person real time.
