"""
luac53 -- read and convert the Blizzard-customised Lua 5.3 bytecode.

``war3map.luac`` inside Reforged 3.0 campaign maps is Lua 5.3 bytecode produced
by a Blizzard build that differs from stock Lua in exactly one way:

===========================  ==================  =====================
item                         stock Lua 5.3       Blizzard build
===========================  ==================  =====================
``sizeof(lua_Integer)``      8 (int64)           4 (int32)
``sizeof(lua_Number)``       8 (double)          4 (float32)
===========================  ==================  =====================

Everything else is stock: ``sizeof(int) = 4``, ``sizeof(size_t) = 8``,
``sizeof(Instruction) = 4``, the 6-byte ``LUAC_DATA``, the ``sizeupvalues``
byte, ``LUAC_INT = 0x5678``, ``LUAC_NUM = 370.5``, constant tags
``0/1/3/4/19``, the 5.3 opcode set, and the string length encoding
(one byte, or ``0xFF`` followed by a size_t).

:func:`luac53.chunk.convert` rewrites a chunk into a stock Lua 5.3 chunk so any
ordinary decompiler can read it; only constant payloads change width, the
instruction stream is copied verbatim.
"""

__version__ = "1.0.0"
__all__ = ["chunk", "disasm"]
