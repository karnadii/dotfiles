# Set 'hx' as the default command-line text editor.
export EDITOR="hx"

# asdf (version manager)
# It is recommended to use asdf to manage all languages (Node, Python, Go, Bun, etc.)
export ASDF_DIR="$HOME/.asdf"
#. $ASDF_DIR/asdf.sh
fpath=(${ASDF_DIR}/internal/completions $fpath)

# Local environment settings
# A good practice for sourcing a file with private environment variables (e.g., API keys).
# This file is not typically checked into version control.
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Dart Pub BIN
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Dart SDK (auto-detect from Flutter via asdf)
export DART_SDK="$HOME/.asdf/installs/flutter/$(ls -t $HOME/.asdf/installs/flutter 2>/dev/null | head -1)/bin/cache/dart-sdk"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

. "$HOME/.cargo/env"

export OPEN_CODE_GO_API_KEY=sk-yfUHQth6ObuOjA4YgYTT6SRosnPYfoTHltlkVFMpiwazQN4Bp4QT0IdAqSBRs9Ta
export OC_GO_CC_API_KEY=$OPEN_CODE_GO_API_KEY
export AGENT_ROUTER_TOKEN=sk-Cw5SYVGmtWfAq0F63n2NKBxqmIylLsogxGM9FGjOpcmUBGNe
export OLLAMA_API_KEY="d77918cb02534eb9a08d8e0812da2f40.DKpIlx-LzM_oJ8bWoZX-K1PQ"
export DEEPSEEK_API_KEY=sk-c5ba22761b3c4a0f8a72be03f303e975
export ZHIPU_API_KEY=bf1548b4f7064dd0882821b76d626c5e.EL6dTNuZwBAVewDN

# Ollama Claude Code
# export ANTHROPIC_AUTH_TOKEN=ollama
# export ANTHROPIC_API_KEY="ollama"
# unset ANTRHOPIC_MODEL
# export ANTHROPIC_BASE_URL=http://localhost:11434
# export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5.1:cloud"
# export ANTHROPIC_DEFAULT_SONNET_MODEL="kimi-k2.6:cloud"
# export ANTHROPIC_DEFAULT_HAIKU_MODEL="minimax-m2.7:cloud"

# AgnetRouter Claude Code
# export ANTHROPIC_BASE_URL=https://agentrouter.org/
# export ANTHROPIC_AUTH_TOKEN=sk-Cw5SYVGmtWfAq0F63n2NKBxqmIylLsogxGM9FGjOpcmUBGNe
# export ANTHROPIC_API_KEY=sk-Cw5SYVGmtWfAq0F63n2NKBxqmIylLsogxGM9FGjOpcmUBGNe
# export ANTHROPIC_MODEL=glm-5.1
# export ANTHROPIC_DEFAULT_OPUS_MODEL=glm-5.1
# export ANTHROPIC_DEFAULT_SONNET_MODEL=glm-5.1
# export ANTHROPIC_DEFAULT_HAIKU_MODEL=glm-4.6

# Deepseek Claude Code
#export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
#export ANTHROPIC_AUTH_TOKEN=$DEEPSEEK_API_KEY
#unset ANTHROPIC_API_KEY
#export ANTHROPIC_MODEL=deepseek-v4-pro[1m]
#export ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro[1m]
#export ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-pro[1m]
#export ANTHROPIC_DEFAULT_HAIKU_MODEL=deepseek-v4-flash
#export CLAUDE_CODE_SUBAGENT_MODEL=deepseek-v4-flash
#export CLAUDE_CODE_EFFORT_LEVEL=max
