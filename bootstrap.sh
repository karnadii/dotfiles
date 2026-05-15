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

# Agent rules (shared across opencode, gemini, claude)
rm -rf "$HOME/.agents/AGENTS.md"
ln -sf "$PWD/dot.agents/AGENTS.md" "$HOME/.agents/AGENTS.md"

# OpenCode — symlink AGENTS.md to central source
ln -sf "$HOME/.agents/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"

# Gemini — symlink GEMINI.md to central source
ln -sf "$HOME/.agents/AGENTS.md" "$HOME/.gemini/GEMINI.md"

# Claude rules — symlink AGENTS.md to central source
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

echo "==> Dotfiles installed! Run 'reload' or 'exec zsh' to apply."
