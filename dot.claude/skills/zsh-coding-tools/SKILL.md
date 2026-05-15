---
name: zsh-coding-tools
description: High-performance CLI tooling available in Karnadi's Zsh environment for code search, file finding, and navigation.
---

# Zsh Coding Agent Tooling

This skill documents the high-performance CLI tools available in Karnadi's shell environment for a coding agent to search, navigate, and inspect codebases efficiently.

---

## Philosophy

The agent should **never** use slow / naive tools when fast alternatives exist:
- ❌ `grep`, `find`, `ls`, `cat` — avoid these in favor of modern tools
- ✅ `rg`, `fd`, `eza`, `bat` — use these instead

---

## File Search: `fd`

Faster, prettier alternative to `find`.

```bash
# Find files by name (glob pattern)
fd "*.dart"
fd -e dart -e yaml "config"

# Find directories
fd --type d --hidden --follow ".git"

# Case-insensitive
fd -i "readme"

# Full path search
fd --full-path "viewmodel" ~/projects/kiryuu/tale-haven
```

Key flags:
- `-H/--hidden` — include hidden files
- `-I/--no-ignore` — don't respect .gitignore
- `-e EXT` — filter by extension
- `-t f/d/l` — type: file / directory / symlink
- `--follow` — follow symlinks
- `-c/--exec` — execute command on results

**Note:** `fd` powers `fzf`'s Ctrl+T (file search) in this shell config.

---

## Content Search: `ripgrep` (rg)

The **primary** search tool for finding patterns in code. Use this before `search_files` tool for exploratory work.

```bash
# Basic regex search
rg "ViewModel" .

# Case-insensitive
rg -i "network" .

# Glob filter
rg "TODO" --type dart
rg "TODO" -g "*.yaml" -g "*.yml"

# Show line numbers
rg -n "class.*Page" .

# Show only filenames (like grep -l)
rg -l "getByRole" .

# Show only matches (like grep -o)
rg -o "https?://[^\s]+"

# Context lines
rg -A2 -B2 "initState" --type dart

# Word boundary (match whole words)
rg -w "build" .

# Count matches per file
rg -c "Provider" --type dart

# Hidden files + no gitignore
rg -ul "pattern" .
```

Key flags:
- `-i` — case insensitive
- `-w` — word boundary
- `-n/--line-number` — show line numbers
- `-l` — only filenames with matches
- `-o` — only the matched text
- `-c` — count per file
- `-A N` — show N lines after match
- `-B N` — show N lines before match
- `-g GLOB` — glob pattern (can stack: `-g "*.dart" -g "*.yaml"`)
- `-u` / `--no-ignore` — don't respect .gitignore
- `-t TYPE` — filter by type (dart, ts, py, sh, etc.)

---

## Fuzzy File Finder: `fzf`

Not directly used by the agent (Hermes uses `search_files` tool), but `fzf` powers the shell's interactive:
- `Ctrl+T` — fuzzy file picker from current directory
- `Ctrl+R` — fuzzy history search
- `Alt+C` — fuzzy directory jump (replaced by `zoxide`)

```bash
# Preview files with bat while browsing (fd feeds into fzf)
fd --type f | fzf --preview 'bat --style=numbers --color=always {}'
```

---

## Directory Jumping: `zoxide` (z)

Smarter `cd` that learns your most-used directories.

```bash
# Jump to a directory (fuzzy matched)
z project-name

# Add to database manually
zoxide add /path/to/dir

# Query the database
zi # interactive mode

# Import cd
eval "$(zoxide init zsh)"
```

**Note:** For the agent, prefer absolute paths. `zoxide` is mainly for interactive shell use.

---

## Git: `forgit`

Interactive git commands via fzf (loaded as `forgit` plugin). The agent should use normal `git` commands — these are for interactive shell use:

```bash
# Interactive staging (replaces `git add -i`)
gst  # or `ga` from OMZ git plugin

# Interactive diff
glo  # log with fzf picker

# Interactive branch checkout
gcb  # checkout branch with fzf

# Interactive stash
gss  # stash show with fzf
```

---

## File Viewing: `bat`

Cat with syntax highlighting, git diff, and line numbers.

```bash
# View file with syntax highlighting
bat ~/.zshrc
bat --theme=andromeda --paging=never ~/.zshrc

# Show line numbers
bat -n main.dart

# Git diff (side-by-side)
bat --diff file1.dart file2.dart

# Search within file (like less)
bat main.dart | less -R

# Show all git changes
bat --diff
```

Key flags:
- `-n/--number` — show line numbers
- `--theme=THEME` — use a specific theme (this shell uses `andromeda`)
- `--diff` — show git diff
- `--paging=never` — don't page (important for piping)
- `-L/--language` — force language detection

**Note:** `bat` in this config has `--paging=never` as an alias, so it won't block in pipes.

---

## File Listing: `eza`

Modern `ls` replacement with icons, git status, and tree view.

```bash
# Long list, human-readable, dirs first
eza -lh --group-directories-first

# All files including hidden
eza -lah --group-directories-first

# Tree view
eza --tree --group-directories-first
eza --tree -L 2 --group-directories-first  # 2 levels deep

# Grid view
eza --grid

# Sort by size, date, etc.
eza -lh --sort=size --group-directories-first
eza -lh --sort=modified --group-directories-first
```

Aliases in the shell:
- `ll` = `eza -lh --group-directories-first`
- `la` = `eza -a --group-directories-first`
- `lla` = `eza -lah --group-directories-first`
- `lt` = `eza --tree --group-directories-first`
- `ltr` = `eza --tree -L 2 --group-directories-first`

---

## Shell Aliases for the Agent

These are available in the interactive shell. The agent's terminal also has these:

| Alias  | Command                                  | Use |
|--------|------------------------------------------|-----|
| `ll`   | `eza -lh --group-directories-first`     | Long list |
| `la`   | `eza -a --group-directories-first`       | All files |
| `lla`  | `eza -lah --group-directories-first`     | Long + all |
| `lt`   | `eza --tree --group-directories-first`   | Tree |
| `ltr`  | `eza --tree -L 2`                        | Tree 2 levels |
| `bat`  | `bat --theme=andromeda --paging=never`   | Cat with syntax |
| `rg`   | `ripgrep`                               | Search content |
| `fd`   | `fd`                                     | Find files |
| `vm`   | `asdf`                                   | Version manager |

---

## Quick Reference

| Task | Command |
|------|---------|
| Find files by name | `fd "*.dart"` |
| Find files in path | `fd --full-path "viewmodel" .` |
| Search content | `rg -n "pattern" -e dart -e yaml` |
| Count matches | `rg -c "TODO" --type dart` |
| List files | `eza -lah --group-directories-first` |
| Tree view | `eza --tree -L 3 --group-directories-first` |
| View with syntax | `bat -n file.dart` |
| Git diff | `bat --diff` |
| Jump to dir | `z project-name` |

---

## Tool Priority Order

When the agent needs to find things, use tools in this order:

1. **`search_files` tool** — best for agent context integration
2. **`rg` (ripgrep)** — for content search across files (use `rg -l` for files-only, `rg -n` for line numbers)
3. **`fd`** — for finding files by name/extension when content search isn't needed
4. **`eza`** — for directory listing and tree views
5. **`bat`** — for reading file contents with highlighting

**Never** use: `find`, `grep` (plain), `cat` (use `bat` instead).

---

## Pitfalls

- `fd` and `rg` both respect `.gitignore` by default — use `-u` / `--no-ignore` to override
- `bat` aliases in this config have `--paging=never` — don't add it again
- `rg -o` outputs only the matched portion, not the full line — useful for extracting values
- `eza --tree` on large directories can be slow — use `-L N` to limit depth
- `zoxide` database is personal to the interactive shell — the agent should use explicit paths