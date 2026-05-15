#!/bin/bash
# Bootstrap developer tool stack for a fresh Linux machine.
# Run: cd ~/dotfiles && ./install-tools.sh
# Or standalone: curl -fsSL https://raw.githubusercontent.com/karnadii/dotfiles/main/install-tools.sh | bash

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BOLD='\033[1m'; NC='\033[0m'

info()  { echo -e "${GREEN}==>${NC} ${BOLD}$1${NC}"; }
warn()  { echo -e "${YELLOW}==>${NC} $1"; }
err()   { echo -e "${RED}==>${NC} $1"; }

# ──────────────────────────────────────────────
# 1. System packages (apt)
# ──────────────────────────────────────────────
install_apt() {
  info "Installing system packages..."
  sudo apt update
  sudo apt install -y \
    curl wget git unzip \
    tmux ripgrep fzf \
    build-essential \
    libssl-dev zlib1g-dev \
    libreadline-dev libyaml-dev \
    libsqlite3-dev libxml2-dev \
    libxslt1-dev libcurl4-openssl-dev \
    libffi-dev libgdbm-dev \
    libncurses5-dev automake libtool \
    bison pkg-config \
    ffmpeg \
    xxd \
    imagemagick \
    htop \
    rsync
}

# ──────────────────────────────────────────────
# 2. Homebrew
# ──────────────────────────────────────────────
install_brew() {
  if command -v brew &>/dev/null; then
    info "Homebrew already installed"
    brew update
  else
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

# ──────────────────────────────────────────────
# 3. Brew packages
# ──────────────────────────────────────────────
install_brew_packages() {
  info "Installing brew packages..."
  brew install \
    git \
    asdf \
    just \
    kew \
    jq \
    yq \
    miniserve \
    ncdu \
    entr \
    yazi
}

# ──────────────────────────────────────────────
# 4. Rust (via rustup, then add via brew)
# ──────────────────────────────────────────────
install_rust() {
  if command -v rustc &>/dev/null; then
    info "Rust already installed"
  else
    info "Installing Rust via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    . "$HOME/.cargo/env"
  fi
}

# ──────────────────────────────────────────────
# 5. asdf plugins & versions
# ──────────────────────────────────────────────
install_asdf() {
  info "Installing asdf plugins..."
  source "$HOME/.asdf/asdf.sh" 2>/dev/null || true

  plugins=(bun flutter golang nodejs python)
  for p in "${plugins[@]}"; do
    asdf plugin add "$p" 2>/dev/null || true
  done

  # Nodejs requires the gpg key import for key validation
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring 2>/dev/null || true

  info "Installing asdf runtimes..."
  asdf install bun latest
  asdf install golang latest
  asdf install nodejs latest
  asdf install python latest

  # Flutter — install latest stable
  asdf install flutter latest

  asdf set -u bun latest
  asdf set -u golang latest
  asdf set -u nodejs latest
  asdf set -u python latest
  asdf set -u flutter latest
}

# ──────────────────────────────────────────────
# 6. Coding agents (opencode, gemini-cli, claude)
# ──────────────────────────────────────────────
install_agents() {
  info "Installing coding agents..."

  # OpenCode
  if command -v opencode &>/dev/null; then
    info "  opencode already installed"
  else
    npm install -g opencode-ai
  fi

  # Gemini CLI
  if command -v gemini &>/dev/null; then
    info "  gemini already installed"
  else
    npm install -g @google/gemini-cli
  fi

  # Claude Code (standalone binary installer)
  if command -v claude &>/dev/null; then
    info "  claude already installed"
  else
    info "  Installing Claude Code..."
    curl -fsSL https://claude.ai/install | bash
  fi
}

# ──────────────────────────────────────────────
# 6b. LSP servers & dev tools (npm global)
# ──────────────────────────────────────────────
install_lsp_servers() {
  info "Installing LSP servers and dev tools..."

  # These are referenced in opencode's LSP/formatter config
  pkgs=(
    prettier
    typescript
    typescript-language-server
    yaml-language-server
    vscode-langservers-extracted
    bash-language-server
    marksman
    "@taplo/lsp"
    "@microsoft/compose-language-service"
  )

  for pkg in "${pkgs[@]}"; do
    if npm ls -g --depth=0 "$pkg" &>/dev/null; then
      info "  $pkg already installed"
    else
      npm install -g "$pkg"
    fi
  done

  info "Installing Python LSP..."
  pip install --user python-lsp-server black pylint 2>/dev/null || pip3 install --user python-lsp-server black pylint

  info "Installing Go LSP (gopls)..."
  go install golang.org/x/tools/gopls@latest 2>/dev/null || true

  info "Installing Rust LSP (rust-analyzer)..."
  rustup component add rust-analyzer 2>/dev/null || true
}

# ──────────────────────────────────────────────
# 7. Snap packages
# ──────────────────────────────────────────────
install_snap() {
  if command -v snap &>/dev/null; then
    info "Installing snap packages..."
    sudo snap install helix --classic 2>/dev/null || true
    sudo snap install ghostty --classic 2>/dev/null || true
  fi
}

# ──────────────────────────────────────────────
# 8. Dotfiles bootstrap
# ──────────────────────────────────────────────
install_dotfiles() {
  info "Symlinking dotfiles..."
  if [ -f "$HOME/dotfiles/bootstrap.sh" ]; then
    bash "$HOME/dotfiles/bootstrap.sh"
  else
    warn "bootstrap.sh not found — run this from ~/dotfiles/"
  fi
}

# ──────────────────────────────────────────────
# 9. Print installed versions
# ──────────────────────────────────────────────
print_versions() {
  echo ""
  info "Installed versions:"
  for cmd in brew asdf bun flutter go node python rustc cargo helix ghostty tmux nano git just kew jq yq miniserve ncdu entr yazi imagemagick htop rsync rg fzf vivid ffmpeg opencode gemini claude; do
    ver="$(command -v "$cmd" &>/dev/null && "$cmd" --version 2>&1 | head -1 || echo 'NOT FOUND')"
    printf "  %-10s %s\n" "$cmd" "$ver"
  done
}

# ──────────────────────────────────────────────
# Main
# ──────────────────────────────────────────────
main() {
  echo ""
  echo "  ╔══════════════════════════════════════╗"
  echo "  ║   Developer Tool Stack Installer     ║"
  echo "  ╚══════════════════════════════════════╝"
  echo ""

  install_apt
  install_brew
  install_brew_packages
  install_rust
  install_asdf
  install_agents
  install_lsp_servers
  install_snap
  install_dotfiles
  print_versions

  echo ""
  info "Done! Restart your shell or run 'exec zsh'."
}

main "$@"
