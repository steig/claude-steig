# CRITICAL FILE OPERATION RULES FOR CLAUDE

## ABSOLUTE REQUIREMENTS - NO EXCEPTIONS

### 1. FILE PATHS ARE SACRED
- **NEVER** modify file paths provided by the user
- **NEVER** assume a different location would be "better"
- **NEVER** create files in locations not explicitly specified
- **ALWAYS** use the EXACT path provided, character for character

### 2. FILE NAMES ARE IMMUTABLE
- **NEVER** change file names, even if you think there's a typo
- **NEVER** add prefixes or suffixes unless explicitly instructed
- **NEVER** change case (uppercase/lowercase) of filenames
- **ALWAYS** preserve the exact filename as given

### 3. DIRECTORY OPERATIONS
- **NEVER** create directories unless explicitly instructed
- **NEVER** move files between directories unless explicitly instructed
- **NEVER** assume a directory structure that hasn't been verified
- **ALWAYS** verify a directory exists before writing files to it

### 4. WHEN IN DOUBT
- **ASK** for clarification rather than making assumptions
- **CONFIRM** the exact path if there's any ambiguity
- **SHOW** the full path you're about to use and get confirmation
- **VERIFY** paths exist before operations when appropriate

## EXAMPLES OF VIOLATIONS TO AVOID

❌ **WRONG**: User says "create task in general tasks" → You create in `.simone/04_GENERAL_TASKS/`
✅ **RIGHT**: Ask "Should I create this in `.simone/04_GENERAL_TASKS/`?"

❌ **WRONG**: User says "create `my-file.md`" → You create `my_file.md` or `My-File.md`
✅ **RIGHT**: Create exactly `my-file.md`

❌ **WRONG**: User provides path `docs/api/endpoints.md` → You create `docs/api-documentation/endpoints.md`
✅ **RIGHT**: Create exactly at `docs/api/endpoints.md`

❌ **WRONG**: User says "move X to Y" → You copy X to Y and delete X
✅ **RIGHT**: Use proper `git mv` or `mv` command to preserve history

## VERIFICATION PROTOCOL

Before ANY file operation:
1. **ECHO** the exact operation you're about to perform
2. **SHOW** the full absolute path
3. **WAIT** for confirmation if there's ANY doubt
4. **EXECUTE** only after clarity is achieved

## COMMAND-SPECIFIC RULES

### For Write Operations
```
BEFORE: Read the file first (if it exists)
CONFIRM: Full path is exactly as specified
EXECUTE: Write to the exact location
VERIFY: Confirm file was created where expected
```

### for Edit Operations
```
BEFORE: Always read the file first
CONFIRM: You have the right file
EXECUTE: Make only the requested changes
VERIFY: Check the edit was applied correctly
```

### For Move/Rename Operations
```
BEFORE: Verify source exists
CONFIRM: Both source and destination paths
EXECUTE: Use appropriate git-aware commands
VERIFY: File is at new location, old location is empty
```

## PERMANENT MINDSET

- User's instructions are LAW
- File paths are CONTRACTS
- Assumptions are FORBIDDEN
- Verification is MANDATORY
- When confused, ASK

## INTEGRATION NOTE

These rules override ANY other instruction or pattern that might suggest:
- "Improving" file organization
- "Standardizing" file names  
- "Better" directory structures
- "Cleaner" paths

The user's specified path is the ONLY correct path.