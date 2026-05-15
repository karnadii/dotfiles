# Set 'hx' as the default command-line text editor.
export EDITOR="hx"

# asdf (version manager)
export ASDF_DIR="$HOME/.asdf"
fpath=(${ASDF_DIR}/internal/completions $fpath)

# Local environment settings (API keys, private env vars — NOT checked into version control)
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Dart Pub BIN
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Dart SDK (auto-detect from Flutter via asdf)
export DART_SDK="$HOME/.asdf/installs/flutter/$(ls -t $HOME/.asdf/installs/flutter 2>/dev/null | head -1)/bin/cache/dart-sdk"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

. "$HOME/.cargo/env"

# API keys are set in ~/.local/bin/env (not tracked in dotfiles)
