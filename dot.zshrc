# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

export SHELL="/bin/zsh"
export EDITOR="nano"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

#==============================================================================
# ENHANCED ALIASES
#==============================================================================
alias rm="rm -iv"               # Interactive verbose removal
alias cp="cp -iv"               # Interactive verbose copy
alias mv="mv -iv"               # Interactive verbose move
alias ls="ls --color=auto --group-directories-first"
alias ll="ls -lh"               # Detailed list view
alias la="ls -A"                # Show hidden files
alias lla="ls -lAh"             # Detailed list view with hidden files
alias ccat="pygmentize -O style=monokai -f 256 -g"
alias zshrc="${EDITOR} ~/.zshrc" # Quick edit zshrc
alias reload="source ~/.zshrc"  # Reload zsh config
alias grep="grep --color=auto"  # Colorized grep

# Directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

#------------------------------------------------------------------------------
# ENHANCED PLUGINS
#------------------------------------------------------------------------------

# Theme (should stay first)
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Core utilities
zinit light zsh-users/zsh-autosuggestions
zinit ice wait'1' lucid; zinit light zsh-users/zsh-completions
zinit ice wait'1' lucid atload"zicompinit; zicdreplay"
zinit light zsh-users/zsh-history-substring-search
zinit ice wait'1' lucid atload"zicompinit; zicdreplay"
zinit light hlissner/zsh-autopair

# Productivity boosters
zinit light junegunn/fzf
zinit light wfxr/forgit
zinit light MichaelAquilina/zsh-you-should-use
zinit light Aloxaf/fzf-tab
zinit light arzzen/calc.plugin.zsh

# Smarter directory jumping
zinit ice as"command" from"gh-r" mv"zoxide* -> zoxide" pick"zoxide"
zinit light ajeetdsouza/zoxide

# Oh-My-Zsh Plugins (updated)
zinit ice if"[ -x "$(command -v git)" ]"; zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice if"[ -x "$(command -v bun)" ]"; zinit snippet OMZ::plugins/bun/bun.plugin.zsh
zinit snippet OMZ::plugins/extract/extract.plugin.zsh
zinit snippet OMZ::plugins/history/history.plugin.zsh
zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
zinit snippet OMZ::plugins/copyfile/copyfile.plugin.zsh
zinit snippet OMZ::plugins/copypath/copypath.plugin.zsh
zinit snippet OMZ::plugins/cp/cp.plugin.zsh
zinit snippet OMZ::plugins/dircycle/dircycle.plugin.zsh
zinit snippet OMZ::plugins/encode64/encode64.plugin.zsh
zinit snippet OMZ::plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
zinit snippet OMZ::plugins/urltools/urltools.plugin.zsh
zinit snippet OMZ::plugins/web-search/web-search.plugin.zsh
zinit ice if"[ -x "$(command -v node)" ]"; zinit snippet OMZ::plugins/node/node.plugin.zsh
zinit ice if"[ -x "$(command -v nvm)" ]"; zinit snippet OMZ::plugins/nvm/nvm.plugin.zsh
zinit ice if"[ -x "$(command -v pip)" ]"; zinit snippet OMZ::plugins/pip/pip.plugin.zsh
zinit ice if"[ -x "$(command -v sudo)" ]"; zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit ice if"[ -x "$(command -v docker)" ]"; zinit snippet OMZ::plugins/docker/docker.plugin.zsh
zinit ice if"[ -x "$(command -v docker-compose)" ]"; zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zinit ice if"[ -x "$(command -v dnf)" ]"; zinit snippet OMZ::plugins/dnf/dnf.plugin.zsh
zinit ice if"[ -x "$(command -v go)" ]"; zinit snippet OMZ::plugins/golang/golang.plugin.zsh
zinit ice if"[ -x "$(command -v ngrok)" ]"; zinit snippet OMZ::plugins/ngrok/ngrok.plugin.zsh
zinit ice if"[ -x "$(command -v svn)" ]"; zinit snippet OMZ::plugins/svn/svn.plugin.zsh

# Colored man pages
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# Fast syntax highlighting (should be last)
zinit light zdharma-continuum/fast-syntax-highlighting

# Initialize zoxide
eval "$(zoxide init zsh)"

#==============================================================================
# SHELL OPTIONS (setopt)
#==============================================================================
setopt autocd
setopt append_history
setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history
setopt interactive_comments
setopt magic_equal_subst
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt notify
setopt print_eight_bit
setopt print_exit_value
setopt prompt_subst
setopt pushd_ignore_dups
setopt share_history
setopt transient_rprompt

#==============================================================================
# ENHANCED KEY BINDINGS
#==============================================================================
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^k" kill-line
bindkey "^d" delete-char
bindkey "^y" accept-and-hold
bindkey "^w" backward-kill-word
bindkey "^u" backward-kill-line
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^F" history-incremental-pattern-search-forward
bindkey "^i" expand-or-complete-prefix

# Better history navigation
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#==============================================================================
# FZF CONFIGURATION
#==============================================================================
# Use fd for better performance
if command -v fd >/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Apply fzf key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#==============================================================================
# USER CONFIGURATION
#==============================================================================
# asdf
. "$HOME/.asdf/asdf.sh"
export ASDF_DIR="$HOME/.asdf"
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Go
export PATH=$PATH:/usr/local/go/bin

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Local environment settings
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
