# -*- coding: utf-8 -*-
"""Audit chapter scripts for paths that can fail, win, exit, or stall a map.

This is a read-only companion to the single-player converter.  It classifies
end-game calls by their trigger registration and guard pattern so fixes can be
reviewed per chapter instead of applying one broad regex to every map.
"""
from __future__ import annotations

import argparse
import json
import re
from dataclasses import asdict, dataclass
from pathlib import Path


RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_ADD_ACTION = re.compile(
    r"TriggerAddAction\(\s*(gg_trg_\w+)\s*,\s*function\s+(\w+)\s*\)"
)
RX_ADD_CONDITION = re.compile(
    r"TriggerAddCondition\(\s*(gg_trg_\w+)\s*,\s*Condition\(function\s+(\w+)\)"
)
RX_REGISTER = re.compile(r"(?m)^[ \t]*call\s+(TriggerRegister\w+)\(([^\r\n]*)\)")
RX_SINK = re.compile(
    r"\b(CustomVictoryBJ|CustomDefeatBJ|EndGame|EndGameBJ|RestartGame|"
    r"CustomRestartBJ|RemovePlayer\w*|SetNextLevelBJ|ReloadGameCachesFromDisk)\s*\("
)


@dataclass(frozen=True)
class FunctionSpan:
    name: str
    start: int
    end: int
    line: int


@dataclass(frozen=True)
class ExitFinding:
    chapter: str
    function: str
    line: int
    call: str
    rule: str
    risk: str
    trigger: str
    condition: str
    events: tuple[str, ...]
    guard: str


def function_spans(text: str) -> dict[str, FunctionSpan]:
    marks = list(RX_FUNC.finditer(text))
    result: dict[str, FunctionSpan] = {}
    for index, match in enumerate(marks):
        start = match.start()
        end = marks[index + 1].start() if index + 1 < len(marks) else len(text)
        result[match.group(1)] = FunctionSpan(
            match.group(1), start, end, text.count("\n", 0, start) + 1
        )
    return result


def body(text: str, span: FunctionSpan) -> str:
    return text[span.start:span.end]


def _nearest_guard(function_body: str, local_offset: int) -> str:
    prefix = function_body[:local_offset]
    candidates = [
        line.strip()
        for line in prefix.splitlines()
        if re.match(r"\s*(?:if|elseif)\b", line)
    ]
    return candidates[-1] if candidates else ""


def _classify(
    function_body: str,
    call: str,
    guard: str,
    condition_body: str,
    events: tuple[str, ...],
) -> tuple[str, str]:
    if call == "ReloadGameCachesFromDisk":
        return "cache-reload", "info"
    if "IB: neutralized" in guard:
        return "neutralized-sentinel", "safe"
    if "R60E" in guard:
        return "platform-map-level-sentinel", "high"
    if "GetItemCharges(" in guard and "'I67C'" in guard:
        return "clear-item-sentinel", "high"
    if (
        call == "CustomDefeatBJ"
        and any("EVENT_PLAYER_UNIT_DEATH" in event for event in events)
        and "GetDyingUnit()" in condition_body
        and "UNIT_TYPE_HERO" in condition_body
    ):
        if re.search(r"GetDyingUnit\(\)\s*==\s*udg_", condition_body):
            return "main-hero-death", "normal"
        return "any-owned-hero-death", "high"
    if call == "SetNextLevelBJ" or any(
        token in function_body
        for token in ("QuestItemSetCompleted(", "QuestSetCompleted(")
    ):
        return "story-transition", "normal"
    if any("PlayerChatEvent" in event for event in events):
        return "chat-only-exit", "cheat-only"
    return "unclassified-end", "review"


def audit_script(path: Path) -> list[ExitFinding]:
    text = path.read_text(encoding="utf-8", errors="surrogateescape")
    spans = function_spans(text)
    action_to_trigger: dict[str, str] = {}
    condition_of: dict[str, str] = {}
    for match in RX_ADD_ACTION.finditer(text):
        action_to_trigger[match.group(2)] = match.group(1)
    for match in RX_ADD_CONDITION.finditer(text):
        condition_of[match.group(1)] = match.group(2)

    findings: list[ExitFinding] = []
    for function, span in spans.items():
        function_body = body(text, span)
        for call_match in RX_SINK.finditer(function_body):
            trigger = action_to_trigger.get(function, "")
            condition = condition_of.get(trigger, "")
            condition_body = body(text, spans[condition]) if condition in spans else ""
            init_name = "Init" + trigger[6:] if trigger.startswith("gg_trg_") else ""
            init_span = spans.get(init_name)
            events = tuple(
                match.group(0).strip()
                for match in RX_REGISTER.finditer(body(text, init_span))
            ) if init_span else ()
            if not events:
                events = tuple(
                    line.strip()
                    for line in text.splitlines()
                    if trigger
                    and ("TriggerRegister" in line or "YDWE" in line)
                    and trigger in line
                )
            guard = _nearest_guard(function_body, call_match.start())
            rule, risk = _classify(
                function_body, call_match.group(1), guard, condition_body, events
            )
            findings.append(
                ExitFinding(
                    chapter=path.stem,
                    function=function,
                    line=text.count("\n", 0, span.start + call_match.start()) + 1,
                    call=call_match.group(1),
                    rule=rule,
                    risk=risk,
                    trigger=trigger,
                    condition=condition,
                    events=events,
                    guard=guard,
                )
            )
    return findings


def markdown(findings: list[ExitFinding]) -> str:
    lines = [
        "# Exit-path audit",
        "",
        "| Chapter | Line | Call | Rule | Risk | Trigger | Guard |",
        "|---|---:|---|---|---|---|---|",
    ]
    for finding in findings:
        guard = finding.guard.replace("|", "\\|")
        if len(guard) > 150:
            guard = guard[:147] + "..."
        lines.append(
            "| %s | %d | %s | %s | %s | %s | `%s` |"
            % (
                finding.chapter,
                finding.line,
                finding.call,
                finding.rule,
                finding.risk,
                finding.trigger or "-",
                guard,
            )
        )
    return "\n".join(lines) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("paths", nargs="+", type=Path)
    parser.add_argument("--json", type=Path)
    parser.add_argument("--markdown", type=Path)
    args = parser.parse_args()

    scripts: list[Path] = []
    for path in args.paths:
        if path.is_dir():
            scripts.extend(sorted(path.glob("*.j")))
        elif path.is_file():
            scripts.append(path)
    findings = [
        finding
        for script in scripts
        for finding in audit_script(script)
    ]
    payload = [asdict(finding) for finding in findings]
    if args.json:
        args.json.write_text(
            json.dumps(payload, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
    if args.markdown:
        args.markdown.write_text(markdown(findings), encoding="utf-8")
    for finding in findings:
        print(
            "%s:%d %-12s %-30s %-8s %s"
            % (
                finding.chapter,
                finding.line,
                finding.call,
                finding.rule,
                finding.risk,
                finding.guard,
            )
        )
    print("findings: %d" % len(findings))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
