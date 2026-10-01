# Luau Deobfuscation

A collection of **random Luau scripts that I've deobfuscated, decrypted, decoded, cleaned up, or reverse engineered**.

Most of these scripts started out as unreadable messes. This repository exists to turn them into something that can actually be understood.

## What This Repo Contains

You'll find various Luau scripts that I've worked on, including:

* Obfuscated Luau
* Encoded or Encrypted strings
* Custom loaders and string decoders
* Heavily minified scripts
* Generated / junk code
* Control-flow obfuscation
* Unnecessarily complicated implementations
* Refactored and cleaned versions of scripts

The scripts are essentially a collection of **"I found this random Luau script and wanted to know what it actually does"** projects.

## Process

My usual workflow looks something like this:

```text
Random Luau script
        ↓
Analyze the structure
        ↓
Identify obfuscation techniques
        ↓
Decode / decrypt constants and strings
        ↓
Trace loaders and execution flow
        ↓
Remove junk and dead code
        ↓
Refactor the logic
        ↓
Readable Luau
```

## Goal

The goal of each project is **understanding**, not simply making the script executable.

When possible, I try to preserve the original behavior while making the code significantly easier to read and analyze.

That can include things like:

```lua
-- Before
local a = function(b)
    return b[(1 + 1) * 2]
end

-- After
local function getValue(values)
    return values[4]
end
```

Of course, real examples are usually much worse than that.

## Notes

Some scripts may contain:

* Broken or incomplete code
* Unresolved functions
* External dependencies
* Roblox-specific APIs
* Obfuscation that cannot be fully recovered
* Behavior that requires a runtime environment to properly analyze

A deobfuscated version may therefore be **functionally equivalent but not identical** to the original source.

## Why Random Scripts?

Because reverse engineering random code is surprisingly fun.

Sometimes there's an interesting obfuscator behind it.

Sometimes there's an elaborate string encryption system.

Sometimes it's several hundred lines of generated nonsense that could have been a few dozen lines, held together by questionable engineering decisions and what I can only assume was a severe lack of sleep.

Either way, I want to know:

> **What does this actually do?**

## Disclaimer

This repository is intended for **educational purposes, code analysis, reverse engineering, and research**.

The contents are provided as-is. I do not claim ownership of scripts that I did not originally create.

Please respect the rights, licenses, and terms associated with any code included in this repository.

---

### Current Status

**Status:** Ongoing

New scripts will probably appear whenever I find another piece of Luau that looks unnecessarily complicated.

```text
find script
   ↓
"who wrote this?"
   ↓
deobfuscate
   ↓
"oh thats what this was."
   ↓
question several life choices
   ↓
next script
```
