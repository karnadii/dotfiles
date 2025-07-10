# Set 'nano' as the default command-line text editor.
export EDITOR="nvim"

# asdf (version manager)
# It is recommended to use asdf to manage all languages (Node, Python, Go, Bun, etc.)
export ASDF_DIR="$HOME/.asdf"
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/internal/completions $fpath)

# Local environment settings
# A good practice for sourcing a file with private environment variables (e.g., API keys).
# This file is not typically checked into version control.
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"