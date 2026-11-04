---
name: Format correction
about: A field, size or algorithm in the documentation is wrong or incomplete
title: ''
labels: documentation
assignees: ''
---

<!--
This is the most valuable kind of report this project gets.  Please describe it
so that it can be checked without anyone copying game files -- see CONTRIBUTING.md,
"Reporting a format discrepancy".

Do NOT attach a map, an extracted file, a decompiled script, a memory dump, or
your license value.
-->

## Which document and field

<!-- e.g. "docs/container-format.md, the trailer's +0x2c digest: documented as
20 bytes, but ..." -->

* document:
* field / offset:
* what it currently says:

## What you observed instead

<!-- Actual offsets, sizes, values-as-roles (not values), field ordering. -->

## How you observed it

<!--
A few lines of disassembly, a hexdump of just the field in question, or a
synthetic reproduction.  Short, targeted excerpts are fine; whole listings and
whole-file dumps are not.
-->

```asm
; e.g.
0x0151xxxx  movzx eax, word ptr [rcx+4]
```

## Does this change behaviour

<!--
Does any shipped code path depend on the field being the other way round?  If a
parser change is needed, say which module and what the corrected check is.
-->

* [ ] documentation only
* [ ] needs a code change as well (module: <!-- w3xd/... or luac53/... -->)

## Confidence

<!--
How sure are you, and what would raise or lower that?  "One sample" and "ran it
against twenty containers" are both useful answers.
-->
