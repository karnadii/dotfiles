#!/bin/bash
# Bootstrap dotfiles for a new machine.
# Run: curl -fsSL https://raw.githubusercontent.com/karnadi/dotfiles/main/bootstrap.sh | bash
# Or: ./bootstrap.sh

set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/karnadi/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

echo "==> Cloning dotfiles..."
git clone --depth 1 "$DOTFILES_REPO" "$DOTFILES_DIR"

cd "$DOTFILES_DIR"

echo "==> Symlinking configs..."
ln -sf "$PWD/dot.zshrc"    "$HOME/.zshrc"
ln -sf "$PWD/dot.zshenv"    "$HOME/.zshenv"
ln -sf "$PWD/dot.p10k.zsh"  "$HOME/.p10k.zsh"
ln -sf "$PWD/dot.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$PWD/dot.nanorc"    "$HOME/.nanorc"
ln -sf "$PWD/dot.gitconfig" "$HOME/.gitconfig"

mkdir -p "$HOME/.config"
for dir in "$PWD/dot.config"/*/; do
  target="$HOME/.config/$(basename "$dir")"
  rm -rf "$target"
  ln -sf "$dir" "$target"
done

# Lock kew state file to prevent theme override on exit.
chmod 444 "$HOME/.config/kew/kewstaterc"

# ── Agent configs ──
# Each has its own JSON structure for MCP but shares the same 7 servers.

# OpenCode config
ln -sf "$PWD/dot.config/opencode/opencode.json" "$HOME/.config/opencode/opencode.json"

# Gemini config + theme (Gemini-native format)
mkdir -p "$HOME/.gemini"
sed "s|HOME_PLACEHOLDER|$HOME|g" "$PWD/dot.gemini/settings.json" > "$HOME/.gemini/settings.json"
cp "$PWD/dot.gemini/themes/andromeda.json" "$HOME/.gemini/themes/andromeda.json"

# Claude config + theme (Claude-native format)
mkdir -p "$HOME/.claude"
ln -sf "$PWD/dot.claude/settings.json" "$HOME/.claude/settings.json"
cp "$PWD/dot.claude/themes/andromeda.json" "$HOME/.claude/themes/andromeda.json"

# Agent rules (shared across opencode, gemini, claude)
mkdir -p "$HOME/.agents"
ln -sf "$PWD/dot.agents/AGENTS.md" "$HOME/.agents/AGENTS.md"

# OpenCode — symlink AGENTS.md
ln -sf "$HOME/.agents/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"

# Gemini — symlink GEMINI.md
ln -sf "$HOME/.agents/AGENTS.md" "$HOME/.gemini/GEMINI.md"

# Claude rules — symlink AGENTS.md + other rules
mkdir -p "$HOME/.claude/rules"
ln -sf "$HOME/.agents/AGENTS.md" "$HOME/.claude/rules/AGENTS.md"
for f in "$PWD/dot.claude/rules"/*.md; do
  [ "$(basename "$f")" = "AGENTS.md" ] && continue
  ln -sf "$f" "$HOME/.claude/rules/$(basename "$f")"
done

# Agent skills (shared across opencode, gemini, claude)
rm -rf "$HOME/.agents/skills"
ln -sf "$PWD/dot.agents/skills" "$HOME/.agents/skills"

# Symlink gemini & claude skills to shared source
rm -rf "$HOME/.gemini/skills"
ln -sf "$HOME/.agents/skills" "$HOME/.gemini/skills"
rm -rf "$HOME/.claude/skills"
ln -sf "$HOME/.agents/skills" "$HOME/.claude/skills"

echo "==> Dotfiles installed!"
echo "    Set your API key in ~/.config/opencode/opencode.json (look for YOUR_API_KEY)"
echo "    Run 'reload' or 'exec zsh' to apply."
