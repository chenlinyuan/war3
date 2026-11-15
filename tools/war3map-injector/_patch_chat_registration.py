# -*- coding: utf-8 -*-
"""Repair dynamic chat registration decompiled as GetEventPlayerChatString().

KKWE/YDWE map scripts sometimes decompile this:

    call TriggerRegisterPlayerChatEvent(trig, Player(0),
        GetEventPlayerChatString(), true)

At map initialization that call receives an empty string, so a later condition
like ``GetEventPlayerChatString() == "GO"`` can never fire.  When the related
condition/action has a single literal command, register that literal directly.
"""
from __future__ import annotations

import re


RX_FUNC = re.compile(r"(?m)^function\s+(\w+)\s+takes\s")
RX_CHAT_REGISTER = re.compile(
    r"TriggerRegisterPlayerChatEvent\(\s*"
    r"(?P<trigger>gg_trg_\w+)\s*,\s*Player\(0\)\s*,\s*"
    r"GetEventPlayerChatString\(\)\s*,\s*true\s*\)"
)
RX_FUNCTION_REF = re.compile(r"function\s+(\w+)\)")
RX_COMMAND = re.compile(
    r'GetEventPlayerChatString\(\)\s*==\s*"([^"]+)"'
)


def patch(text: str) -> tuple[str, list[dict[str, str]]]:
    marks = [(match.start(), match.group(1)) for match in RX_FUNC.finditer(text)]
    functions: dict[str, str] = {}
    for index, (start, name) in enumerate(marks):
        end = marks[index + 1][0] if index + 1 < len(marks) else len(text)
        functions[name] = text[start:end]

    edits: list[tuple[int, int, str]] = []
    records: list[dict[str, str]] = []
    for init_name, init_body in functions.items():
        if not init_name.startswith("InitTrig"):
            continue
        for match in RX_CHAT_REGISTER.finditer(init_body):
            related = init_body
            for referenced in RX_FUNCTION_REF.findall(init_body):
                related += "\n" + functions.get(referenced, "")
            commands = sorted(set(RX_COMMAND.findall(related)))
            if len(commands) != 1:
                continue
            command = commands[0]
            function_pos = text.find("function " + init_name)
            registration = match.group(0)
            replacement = registration.replace(
                "GetEventPlayerChatString()",
                '"%s"' % command,
                1,
            )
            line_start = text.find(registration, function_pos)
            if line_start < 0:
                continue
            edits.append((line_start, line_start + len(registration), replacement))
            records.append(
                {
                    "function": init_name,
                    "trigger": match.group("trigger"),
                    "command": command,
                }
            )

    output = text
    for start, end, replacement in sorted(edits, reverse=True):
        output = output[:start] + replacement + output[end:]
    return output, records


def verify(text: str) -> list[str]:
    return sorted(
        match.group("trigger")
        for match in RX_CHAT_REGISTER.finditer(text)
        if '"GO"' in _nearby_condition(text, match.group("trigger"))
    )


def _nearby_condition(text: str, trigger: str) -> str:
    start = max(0, text.find(trigger) - 2000)
    end = min(len(text), text.find(trigger) + 2000)
    return text[start:end]
