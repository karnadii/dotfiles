#==============================================================================
# ZPLUG PLUGIN MANAGER
#==============================================================================

# Check if zplug is installed, if not, clone it
if [[ ! -d ~/.zplug ]]; then
    echo "Installing zplug..."
    git clone https://github.com/zplug/zplug ~/.zplug
fi

# Initialize zplug
export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

export SHELL="/bin/zsh"
export EDITOR="nano"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

#==============================================================================
# ALIASES
#==============================================================================

alias rm="rm -v"
alias cp="cp -v"
alias mv="mv -v"
alias ls="ls --color=auto"
alias ccat="pygmentize -O style=monokai -f 256 -g"
alias cat="ccat"

#------------------------------------------------------------------------------
# Plugins
#------------------------------------------------------------------------------

# Theme
zplug "romkatv/powerlevel10k", as:theme, depth:1

# Zsh Standard Plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "hlissner/zsh-autopair", defer:2

# Oh-My-Zsh Plugins
zplug "plugins/git", from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/bun", from:oh-my-zsh, if:"(( $+commands[bun] ))"
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/autoenv", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/copyfile", from:oh-my-zsh
zplug "plugins/copypath", from:oh-my-zsh
zplug "plugins/cp", from:oh-my-zsh
zplug "plugins/dircycle", from:oh-my-zsh
zplug "plugins/encode64", from:oh-my-zsh
zplug "plugins/fancy-ctrl-z", from:oh-my-zsh
zplug "plugins/urltools", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh, if:"(( $+commands[node] ))"
zplug "plugins/npm", from:oh-my-zsh, if:"(( $+commands[npm] ))"
zplug "plugins/nvm", from:oh-my-zsh, if:"(( $+commands[nvm] ))"
zplug "plugins/pip", from:oh-my-zsh, if:"(( $+commands[pip] ))"
zplug "plugins/sudo", from:oh-my-zsh, if:"(( $+commands[sudo] ))"
zplug "plugins/docker", from:oh-my-zsh, if:"(( $+commands[docker] ))"
zplug "plugins/docker-compose", from:oh-my-zsh, if:"(( $+commands[docker-compose] ))"
zplug "plugins/dnf", from:oh-my-zsh, if:"(( $+commands[dnf] ))"
zplug "plugins/flutter", from:oh-my-zsh, if:"(( $+commands[flutter] ))"
zplug "plugins/golang", from:oh-my-zsh, if:"(( $+commands[go] ))"
zplug "plugins/ngrok", from:oh-my-zsh, if:"(( $+commands[ngrok] ))"
zplug "plugins/svn", from:oh-my-zsh, if:"(( $+commands[svn] ))"

# Productivity Tools
zplug "junegunn/fzf", as:command
# zplug "wfxr/forgit", from:github
zplug "arzzen/calc.plugin.zsh"
zplug "joel-porquet/zsh-dircolors-solarized"


#==============================================================================
# SHELL OPTIONS (setopt)
#==============================================================================

setopt autocd                   # Change directories without `cd`.
setopt append_history           # Append to history file.
setopt auto_list                # Automatically list choices on ambiguous completion.
setopt auto_menu                # Show completion menu on successive tabs.
setopt auto_pushd               # Make `cd` push the old directory onto the directory stack.
setopt extended_history         # Record timestamp and duration of commands.
setopt hist_expire_dups_first   # Expire duplicate entries first when trimming history.
setopt hist_find_no_dups        # Don't display duplicates when searching history.
setopt hist_ignore_all_dups     # Delete old commands if a new one is a duplicate.
setopt hist_ignore_dups         # Don't record immediate consecutive duplicates.
setopt hist_ignore_space        # Don't record commands starting with a space.
setopt hist_reduce_blanks       # Remove superfluous blanks from history items.
setopt hist_save_no_dups        # Don't write duplicate history entries to the history file.
setopt inc_append_history       # Write to the history file immediately, not at shell exit.
setopt interactive_comments     # Allow comments in interactive shell.
setopt magic_equal_subst        # Perform filename expansion for arguments of the form `foo=bar`.
setopt no_beep                  # No beeps.
setopt no_hist_beep             # No beep on history wrap-around.
setopt no_list_beep             # No beep on ambiguous completion.
setopt notify                   # Report status of background jobs immediately.
setopt print_eight_bit          # Print eight-bit characters.
setopt print_exit_value         # Print exit value of programs with non-zero exit status.
setopt prompt_subst             # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt.
setopt pushd_ignore_dups        # Don't push directories that are already on the stack.
setopt share_history            # Share history between all shells.
setopt transient_rprompt        # Show a transient rprompt (right prompt).


# Common CTRL bindings.
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

# Do not require a space when attempting to tab-complete.
bindkey "^i" expand-or-complete-prefix
#==============================================================================
# LS_COLORS
#==============================================================================

# Solarized dircolors
if [ -x "$(command -v dircolors)" ] && [ -f "$HOME/.zplug/repos/joel-porquet/zsh-dircolors-solarized/dircolors.256dark" ]; then
    eval "$(dircolors -b $HOME/.zplug/repos/joel-porquet/zsh-dircolors-solarized/dircolors.256dark)"
fi




# Install plugins if they aren't installed
if ! zplug check; then
    echo "Some zplug plugins are not installed."
    printf "Install missing zplug pluginn? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Load plugins
zplug load



#==============================================================================
# USER CONFIGURATION
#==============================================================================
# asdf
. "$HOME/.asdf/asdf.sh"
# append completions to fpath
export  ASDF_DIR="$HOME/.asdf"
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Go
export PATH=$PATH:/usr/local/go/bin

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Local environment settings
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
