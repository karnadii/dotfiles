# dotfiles

Karnadi's Zsh-centric dotfiles — Andromeda themed across all tools.

## What's included

| Tool | Config |
|------|--------|
| **zsh** | `.zshrc`, `.zshenv`, `.p10k.zsh` |
| **tmux** | `.tmux.conf` |
| **opencode** | `opencode.json`, `AGENTS.md`, `themes/andromeda.json` |
| **helix** | `config.toml`, `languages.toml`, `themes/andromeda.toml` |
| **ghostty** | `config` |
| **kew** | `kewrc`, `themes/andromeda.theme` |
| **bat** | `themes/andromeda/andromeda.tmTheme` |
| **vivid** | `themes/andromeda.yml` |
| **nano** | `.nanorc` |
| **git** | `.gitconfig` |
| **claude** | `rules/*.md` |
| **gemini** | `GEMINI.md`, `skills/zsh-coding-tools` |

## Install

```bash
git clone https://github.com/karnadi/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./bootstrap.sh
```

## Structure

```
dotfiles/
├── bootstrap.sh          # Install script
├── dot.zshrc             # → ~/.zshrc
├── dot.p10k.zsh          # → ~/.p10k.zsh
├── dot.tmux.conf         # → ~/.tmux.conf
├── dot.zshenv            # → ~/.zshenv
├── dot.nanorc            # → ~/.nanorc
├── dot.gitconfig         # → ~/.gitconfig
├── dot.claude/           # → ~/.claude/
├── dot.gemini/           # → ~/.gemini/
├── dot.config/           # → ~/.config/
│   ├── ghostty/
│   ├── helix/
│   ├── kew/
│   ├── opencode/
│   └── vivid/
└── terminal/             # Terminal-specific
