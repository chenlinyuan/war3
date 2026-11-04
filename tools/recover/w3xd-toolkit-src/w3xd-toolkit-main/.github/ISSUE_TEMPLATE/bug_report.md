---
name: Bug report
about: Something in the toolkit is wrong or crashes
title: ''
labels: bug
assignees: ''
---

<!--
Reminder before you paste anything: do NOT attach a map, an extracted file, a
decompiled script, or your license value.  See CONTRIBUTING.md, ground rule 1.
-->

## What happened

<!-- The command you ran and what it did. -->

```console
$ w3xd ...
```

## What you expected

<!-- ... -->

## Reproduction

<!--
The smallest thing that shows the problem.  If it only happens with your own
map, describe the container instead of attaching it: file size, the `hdr_size`
and `payload_size` that `w3xd info` reports, and whether `--payload` verifies.

Where possible, turn it into a synthetic case with `w3xd.container.build()`
or `tests/test_mpq.py::build_mpq` and paste that code -- it makes the bug
fixable without anyone holding your files.
-->

## Environment

| | |
|---|---|
| toolkit version | <!-- `w3xd --version` --> |
| Python | <!-- `python -V` --> |
| OS | <!-- e.g. Windows 11, Ubuntu 24.04, macOS 15 --> |
| Java (for `luac53 decompile`) | <!-- `java -version` --> |

## Output

<!--
Full traceback if there is one.  `w3xd info FILE --payload` is the most useful
single piece of diagnostic output for container problems.
-->
