# dotfiles

Karnadi's Zsh-centric dotfiles — **Andromeda** themed across the entire stack.

## Quick start

```bash
# 1. Clone
git clone https://github.com/karnadii/dotfiles.git ~/dotfiles

# 2. Install full tool stack
~/dotfiles/install-tools.sh

# 3. Symlink configs
~/dotfiles/bootstrap.sh

# 4. Restart shell
exec zsh
```

## What's included

### Andromeda theme
Every tool uses the same Andromeda palette (`#23262E` / `#D5CED9` / `#00e8c6` — dark teal accent).

| Tool | Config | Theme |
|------|--------|-------|
| **zsh** | `.zshrc`, `.zshenv`, `.p10k.zsh` | ✅ p10k + fast-syntax-highlighting |
| **tmux** | `.tmux.conf` | ✅ status bar with Andromeda variables |
| **ghostty** | `config` | ✅ built-in Andromeda |
| **opencode** | `opencode.json`, `AGENTS.md`, `themes/andromeda.json` | ✅ full theme |
| **gemini** | `settings.json`, `GEMINI.md` | ✅ custom theme via file |
| **claude** | `settings.json`, `rules/AGENTS.md` | ✅ custom theme via overrides |
| **helix** | `config.toml`, `languages.toml`, `themes/andromeda.toml` | ✅ custom theme |
| **kew** | `kewrc`, `themes/andromeda.theme` | ✅ custom theme |
| **bat** | `themes/andromeda/andromeda.tmTheme` | ✅ |
| **vivid** | `themes/andromeda.yml` | ✅ LS_COLORS |
| **nano** | `.nanorc` | ✅ UI colors |
| **fzf** | `.zshrc` (FZF_DEFAULT_OPTS) | ✅ colors |
| **git** | `.gitconfig` | — |

### Coding agents (shared config)

All three agents share the same **MCP servers (7)**, **rules (AGENTS.md)**, and **skills (22)** via symlinks to `~/.agents/`:

```
~/.agents/
├── AGENTS.md       ← single source of truth
└── skills/         ← 22 shared skills
     ├── zsh-coding-tools
     ├── find-docs
     ├── find-skills
     ├── dart-* (9 skills)
     └── flutter-* (9 skills)
```

| Agent | Config | MCP servers | Rules | Skills |
|-------|--------|-------------|-------|--------|
| **opencode** | `~/.config/opencode/` | 7 ✅ | AGENTS.md symlink ✅ | symlink ✅ |
| **gemini** | `~/.gemini/` | 7 ✅ | GEMINI.md symlink ✅ | symlink ✅ |
| **claude** | `~/.claude/` | 7 ✅ | AGENTS.md in rules/ ✅ | symlink ✅ |

## Installed tools

### Tool stack (`install-tools.sh`)

| Category | Tools |
|----------|-------|
| **System** | tmux, ripgrep, fzf, ffmpeg, imagemagick, htop, build-essential |
| **Package mgr** | Homebrew, asdf, snap, rustup, pip |
| **Languages** | bun, flutter, golang, nodejs, python, rust |
| **CLI tools** | just, kew, yq, jq, miniserve, ncdu, entr, yazi |
| **Editor** | helix (snap), nano, ghostty (snap) |
| **Version mgr** | asdf with bun, flutter, golang, nodejs, python |
| **Coding agents** | opencode-ai (npm), @google/gemini-cli (npm), claude (standalone) |
| **LSP servers** | typescript-language-server, yaml-language-server, bash-language-server, vscode-langservers-extracted (html/css/json/eslint/md), taplo, marksman, pylsp, gopls, rust-analyzer |
| **Formatters** | prettier, black (python), rustfmt, dart format, goimports |

> **Note:** bat, eza, fd, rg, zoxide are installed by zinit when `.zshrc` is sourced.

## Structure

```
dotfiles/
├── install-tools.sh       # Full tool stack installer
├── bootstrap.sh            # Symlink configs to home
├── README.md
│
├── dot.zshrc              # → ~/.zshrc
├── dot.zshenv             # → ~/.zshenv
├── dot.p10k.zsh           # → ~/.p10k.zsh
├── dot.tmux.conf          # → ~/.tmux.conf
├── dot.nanorc             # → ~/.nanorc
├── dot.gitconfig          # → ~/.gitconfig
│
├── dot.agents/            # → ~/.agents/
│   ├── AGENTS.md          #   Shared rules
│   └── skills/            #   Shared skills (22)
│
├── dot.config/            # → ~/.config/
│   ├── ghostty/
│   ├── helix/
│   ├── kew/
│   ├── opencode/
│   └── vivid/
│
├── dot.claude/            # → ~/.claude/
│   ├── settings.json
│   ├── themes/andromeda.json
│   └── rules/
│
└── dot.gemini/            # → ~/.gemini/
    ├── settings.json
    ├── themes/andromeda.json
    └── GEMINI.md
```

## API keys

The dotfiles repo uses `YOUR_API_KEY` placeholders. Set your actual keys locally:

- `~/.zshenv` → export your API keys here
- `~/.config/opencode/opencode.json` → replace `YOUR_API_KEY` in the provider section
- `~/.local/bin/env` → sourced by `.zshenv` for private vars (not tracked)
