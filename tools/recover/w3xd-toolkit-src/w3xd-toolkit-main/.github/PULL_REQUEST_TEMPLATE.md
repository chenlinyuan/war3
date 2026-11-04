<!--
Thanks for contributing.  Please read CONTRIBUTING.md first if you have not:
https://github.com/mythic-p/w3xd-toolkit/blob/main/CONTRIBUTING.md
-->

## What this changes

<!-- One or two sentences.  What was wrong or missing, and what you did. -->

## Why

<!--
For a format change: which document says otherwise, and what evidence do you
have (offset, size, a few lines of disassembly)?  For a bug fix: what was the
observable failure?
-->

## How it was tested

<!--
`python -m unittest discover -s tests -t .` on a clean checkout, plus any new
test you added.  "Works on my machine" is not enough for a format change.
-->

```
paste the test run here
```

---

## Checklist

Contributions that cannot tick every box will be asked to change, so please
check honestly rather than optimistically.

- [ ] **No game data.** The diff contains no `.w3x` / `.w3m` / `.w3n` / `.w3xd` /
      `.mpq` / `.luac` files, nothing from a `*.files/` directory, no extracted
      assets, and no decompiled `war3map.lua` from a shipped map.
- [ ] **No keys.** The diff contains no license value and no derived AES key,
      and neither appears in the description above.
- [ ] **No new runtime dependency.** The package still installs and runs with
      no third-party imports. (Optional dev extras are fine.)
- [ ] **Tested offline.** Every format-touching change has a test that passes on
      a clean checkout with no game files present, and it covers the negative
      case as well as the happy path.
- [ ] **Docs updated.** If a field, size or behaviour changed, the matching
      document in `docs/` is updated in this same pull request.
- [ ] **Both READMEs.** If `README.md` changed, `README.zh-CN.md` did too (and
      vice versa), with the language switcher on line 3 intact.
- [ ] **One logical change.** No unrelated reformatting or drive-by edits.

## Notes for the reviewer

<!-- Anything you are unsure about, or decided differently from the docs. -->
