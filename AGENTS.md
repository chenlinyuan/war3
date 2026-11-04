# War3 Workspace Automation Boundaries

## Never launch or operate the game

- Do not launch, automate, capture, click, type into, or otherwise interact with
  Warcraft III, World Editor, or any other game/editor GUI process.
- This includes `Warcraft III.exe`, `War3.exe`, World Editor, window
  screenshots, SendKeys, UI automation, and command-line `-loadfile` testing.
- Static inspection, object/script parsing, unit tests, pjass, archive
  validation, hashing, and Map Doctor checks remain allowed.
- If runtime verification is required, stop before launching anything. Give
  the user exact test steps, expected observable results, and where to report
  back, then wait for the user's result.

The user explicitly requires: "不要打开游戏。需要测试告诉我即可。"
