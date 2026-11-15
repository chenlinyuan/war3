# Campaign repair plugins

Every KK/Xiao Jia campaign gets its own SHA-locked bundle here. Shared
campaign tooling discovers these manifests automatically; it does not copy
rules from one campaign to another.

## Bundle layout

```text
campaign_plugins/<slug>/
  __init__.py
  manifest.json
  key_policy.py
  chapter_rules.py
  program.py
  patch.py
  audit.py
  tests/
```

`manifest.json` is the source of truth for:

- source `.w3n` SHA-256 and campaign title;
- chapter order;
- mall keys proven true/false and the unknown-key default;
- exact chapter sets for each destructive anti-cheat rule;
- authored backpack-switch ability IDs and their object/script references;
- expected hit counts and preserved intentional failure paths;
- required runtime tests.

`patch.py` must expose:

```python
patch(text: str, chapter: str) -> tuple[str, dict[str, object]]
verify(text: str, stats: dict[str, object]) -> list[str]
```

The converter selects the bundle by the clean source SHA-256, applies the
generic porting primitives, then runs this campaign-specific patch and fails
the build if hit counts or `verify()` do not match the manifest.

## Adding another campaign

1. Build from a clean original `.w3n`; never use a previously patched output.
2. Inventory every mall key, death/defeat trigger, group wipe, pet deletion,
   cache handoff, command gate, and cinematic exit.
3. Create a new bundle with its own source SHA and exact rule chapter sets.
4. Preserve story failures and only neutralize anti-platform behavior.
5. Add synthetic positive/negative tests plus real-build count assertions.
6. Run pjass, Map Doctor, Storm subarchive checks, read-back checks, and
   deployed-hash verification.

Do not add a campaign ID, unit ID, task handle, or key to the shared layer
until it is a pattern-based primitive with independent tests.
