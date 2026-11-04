# ALAS W3Z Save Repair CLI

`offline_save_repair.py` can run without the Tkinter interface. It repairs
only the saved map identity (checksum and SHA-1), validates every W3Z block,
and creates a backup before replacing a save. It does not change saved Lua,
inventory, quests, or other game state.

For manual command-line use, `Repair-Alas-Saves-CLI.cmd` forwards all
arguments to the Python entry point:

```powershell
tools\recover\Repair-Alas-Saves-CLI.cmd --campaign "...\campaign.w3n" `
  --save "...\1.w3z" --yes --json
```

## Requirements

- Python 3.
- `node` available on `PATH`.
- An explicit campaign path in automation. Otherwise the tool falls back to
  the most recently modified `alas*.w3n`.

## Validate one save without writing

```powershell
python tools\recover\offline_save_repair.py `
  --campaign "C:\path\to\alas-campaign.w3n" `
  --save "C:\path\to\Campaigns\Custom\alas-campaign\1.w3z" `
  --yes `
  --json
```

Without `--apply`, the command is a dry run. It builds and verifies a repaired
copy in a temporary directory, then deletes it without touching the original.

## Repair one save

```powershell
python tools\recover\offline_save_repair.py `
  --campaign "C:\path\to\alas-campaign.w3n" `
  --save "C:\path\to\Campaigns\Custom\alas-campaign\1.w3z" `
  --apply `
  --yes `
  --json
```

The save's parent directory is used as the save root. If companion snapshots
exist under `CustomSaves`, the tool selects and repairs the matching bundle.

## Command-line behavior

- `--apply`: write validated repairs. Without it, the command is a dry run.
- `--yes`: never prompt. Missing required paths become an error.
- `--json`: print exactly one JSON result and suppress human-readable logs.
- `--quiet`: suppress human-readable logs without JSON.
- Exit code `0`: all selected saves validated and, when requested, were applied.
- Exit code `1`: invalid paths, invalid save structure, a skipped repair that
  was needed, or another processing error.

When `--json` is used, an error is also returned as JSON:

```json
{
  "ok": false,
  "error": "campaign file not found"
}
```

## JSON result

Successful results have this shape:

```json
{
  "ok": true,
  "dry_run": false,
  "campaign": "C:\\path\\to\\alas-campaign.w3n",
  "save_dir": "C:\\path\\to\\Campaigns\\Custom\\alas-campaign",
  "selected_save": "C:\\path\\to\\Campaigns\\Custom\\alas-campaign\\1.w3z",
  "companion_snapshots": 0,
  "changed": 1,
  "already_current": 0,
  "skipped": 0,
  "backup": "C:\\path\\to\\Campaigns\\Custom\\save-repair-backup-20261104-123456",
  "rows": [
    {
      "save": "1.w3z",
      "map": "orcrpg01.w3m",
      "status": "OK",
      "old_checksum": "5b1d36c6",
      "new_checksum": "a0c79bb6",
      "blocks": 27,
      "error": null
    }
  ]
}
```

`status` is one of `OK`, `CURRENT`, `SKIP: map not in campaign`, or `ERROR`.
`backup` is `null` during a dry run, when no save changed, or when all saves
were already current.

## Calling from Python

For an in-process call, add the direct recovery-tool directory to
`sys.path`:

```python
import sys
from pathlib import Path

sys.path.insert(0, str(tool_root / "tools" / "recover"))
import offline_save_repair

report = offline_save_repair.repair_saves(
    campaign=Path(campaign_path),
    save_dir=Path(save_path).parent,
    apply_changes=True,
    selected_save=Path(save_path),
    quiet=True,
)
if not report["ok"]:
    raise RuntimeError("save repair failed")
```

The function raises an exception on a hard failure. Its returned dictionary is
serializable with `json.dumps`.

When invoking the CLI from a Windows GUI, launch the Python process with
`CREATE_NO_WINDOW`; the tool itself also hides its Node and `tasklist` child
processes.
