#==============================================================================
# 🚀 INSTANT PROMPT & PLUGIN MANAGER
#==============================================================================

# Enable Powerlevel10k instant prompt for near-instant shell startup.
# This should stay at the very top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer ###
# This block checks if Zinit (a Zsh plugin manager) is installed.
# If not, it clones the repository from GitHub to automatically install it.
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

# Source the Zinit script to load the plugin manager into the shell.
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
# Load Zinit's own completions.
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#==============================================================================
# ⚙️ ENVIRONMENT VARIABLES
#==============================================================================

# Set Zsh as the default shell environment for other programs.
export SHELL="/bin/zsh"
# Define the path to the shell history file.
export HISTFILE="$HOME/.zsh_history"
# Set the maximum number of lines to keep in memory for history.
export HISTSIZE=10000
# Set the maximum number of lines to save in the history file.
export SAVEHIST=$HISTSIZE


#==============================================================================
# ✨ ENHANCED ALIASES
#==============================================================================

# Safer file operations: prompt before overwriting/deleting (-i) and be verbose (-v).
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"
alias vim="nvim"
alias vi="nvim"
# Replace standard commands with modern, better alternatives.
alias ls="eza --color=auto --group-directories-first"  # Use 'eza' for listings.
alias cat="bat --theme=andromeda"                      # Use 'bat' for viewing files with syntax highlighting.
alias grep="rg"                                        # Use 'ripgrep' (rg) for faster, better searching.

# Common 'ls' (eza) shortcuts.
alias ll="ls -lh"      # Detailed list view (long, human-readable).
alias la="ls -a"       # Show hidden files (dotfiles).
alias lla="ls -lah"    # Detailed list view with hidden files.
alias lt="ls --tree"   # Tree view of the current directory.
alias ltr="ls --tree -L 2" # Tree view limited to 2 levels deep.

# Convenience aliases.
alias zshrc="${EDITOR} ~/.zshrc" # Quickly open this file for editing.
alias reload="source ~/.zshrc"  # Quickly apply changes to this file.

# Directory navigation shortcuts.
# alias ..="cd .." # Not needed; handled by the 'autocd' option.
alias ...="cd ../.."
alias ....="cd ../../.."

#------------------------------------------------------------------------------
# 🎨 DIRCOLORS SETUP
#------------------------------------------------------------------------------

# This section configures colors for file listings (ls, eza, etc.).
# It prioritizes 'vivid' to generate a nice color theme (catppuccin-latte).
if command -v vivid &> /dev/null; then
    export LS_COLORS="$(vivid generate ~/.config/vivid/themes/andromeda.yml)"
# If 'vivid' is not found, it falls back to a user-defined or default dircolors file.
elif [[ -f ~/.dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
else
    # Fallback to default system colors.
    eval "$(dircolors -b)"
fi

# Apply the generated colors to 'eza' and Zsh's built-in completion system.
export EXA_COLORS="$LS_COLORS"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

#------------------------------------------------------------------------------
# 🧩 ZINIT PLUGINS
#------------------------------------------------------------------------------

# --- Theme (should be loaded first for prompt speed) ---
# `zinit ice depth=1` does a shallow clone for faster installation.
zinit ice depth=1; zinit light romkatv/powerlevel10k

# --- Core Shell Utilities ---
# Fish-like autosuggestions based on command history.
zinit light zsh-users/zsh-autosuggestions
# Advanced tab completions for many common commands.
# `ice wait'1' lucid` loads the plugin after a 1-second delay without printing messages.
zinit ice wait'1' lucid; zinit light zsh-users/zsh-completions
# Allows searching history by typing a substring and pressing Up/Down arrows.
zinit ice wait'1' lucid atload"zicompinit; zicdreplay"
zinit light zsh-users/zsh-history-substring-search
# Automatically adds closing brackets, quotes, etc.
zinit ice wait'1' lucid atload"zicompinit; zicdreplay"
zinit light hlissner/zsh-autopair

# --- Productivity Boosters ---
zinit light junegunn/fzf                     # A command-line fuzzy finder.
zinit light wfxr/forgit                      # Interactive git commands using fzf.
zinit light MichaelAquilina/zsh-you-should-use # Reminds you to use existing aliases.
# zinit light Aloxaf/fzf-tab                   # Replaces Zsh's completion menu with fzf.
zinit light arzzen/calc.plugin.zsh           # A simple calculator in Zsh.

# --- Modern Command Replacements (installed via Zinit) ---
# 'zinit ice as"command"...' downloads the binary from GitHub Releases and puts it on the PATH.
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd
zinit ice as"command" from"gh-r" mv"rg* -> rg" pick"rg/rg"
zinit light BurntSushi/ripgrep
zinit ice as"command" from"gh-r" mv"eza* -> eza" pick"eza/eza"
zinit light eza-community/eza

# --- Smarter Directory Jumping ---
# 'zoxide' learns your most used directories for quick navigation (e.g., `z project`).
zinit ice as"command" from"gh-r" mv"zoxide* -> zoxide" pick"zoxide"
zinit light ajeetdsouza/zoxide

# --- Oh-My-Zsh (OMZ) Plugins ---
# Zinit can load OMZ plugins without needing the full framework.
# `ice if"[...` only loads the plugin if the specified command exists.
zinit ice if"[ -x "$(command -v git)" ]"; zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice if"[ -x "$(command -v bun)" ]"; zinit snippet OMZ::plugins/bun/bun.plugin.zsh
zinit snippet OMZ::plugins/extract/extract.plugin.zsh # 'extract' any archive type.
zinit snippet OMZ::plugins/history/history.plugin.zsh # `h` for history search.
zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
zinit snippet OMZ::plugins/copyfile/copyfile.plugin.zsh # `copyfile <file>` to clipboard.
zinit snippet OMZ::plugins/copypath/copypath.plugin.zsh   # `copypath` to clipboard.
zinit snippet OMZ::plugins/cp/cp.plugin.zsh
zinit snippet OMZ::plugins/dircycle/dircycle.plugin.zsh # Cycle through recent directories.
zinit snippet OMZ::plugins/encode64/encode64.plugin.zsh # base64 encoding/decoding.
zinit snippet OMZ::plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh # Better Ctrl+Z handling.
zinit snippet OMZ::plugins/urltools/urltools.plugin.zsh # URL encoding/decoding.
# zinit snippet OMZ::plugins/web-search/web-search.plugin.zsh # e.g., 'google something'. # BROKEN TOOLS
zinit snippet OMZ::plugins/asdf/asdf.plugin.zsh
zinit ice if"[ -x "$(command -v node)" ]"; zinit snippet OMZ::plugins/node/node.plugin.zsh
zinit ice if"[ -x "$(command -v nvm)" ]"; zinit snippet OMZ::plugins/nvm/nvm.plugin.zsh
zinit ice if"[ -x "$(command -v pip)" ]"; zinit snippet OMZ::plugins/pip/pip.plugin.zsh
zinit ice if"[ -x "$(command -v sudo)" ]"; zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit ice if"[ -x "$(command -v docker)" ]"; zinit snippet OMZ::plugins/docker/docker.plugin.zsh
zinit ice if"[ -x "$(command -v docker-compose)" ]"; zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zinit ice if"[ -x "$(command -v go)" ]"; zinit snippet OMZ::plugins/golang/golang.plugin.zsh
zinit ice if"[ -x "$(command -v ngrok)" ]"; zinit snippet OMZ::plugins/ngrok/ngrok.plugin.zsh
zinit ice if"[ -x "$(command -v svn)" ]"; zinit snippet OMZ::plugins/svn/svn.plugin.zsh
zinit ice if"[ -x "$(command -v brew)" ]"; zinit snippet OMZ::plugins/brew/brew.plugin.zsh

# --- Colored Man Pages ---
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# --- Fast Syntax Highlighting (should be loaded last) ---
zinit light zdharma-continuum/fast-syntax-highlighting

# Initialize zoxide to enable its functionality in the shell.
eval "$(zoxide init zsh)"

#==============================================================================
# 🐚 SHELL OPTIONS (setopt)
#==============================================================================
# These options fine-tune Zsh's behavior.

setopt autocd                  # Type a directory name to 'cd' into it.
setopt append_history          # Appends history to file instead of overwriting.
setopt auto_list               # Automatically list choices on ambiguous completion.
setopt auto_menu               # Show a menu for completion choices.
setopt auto_pushd              # Automatically manage a directory stack.
setopt extended_history        # Save timestamps and duration for each command.
setopt hist_expire_dups_first  # When trimming history, remove duplicates first.
setopt hist_find_no_dups       # Don't show duplicates when searching history.
setopt hist_ignore_all_dups    # If a new command is a duplicate, remove the old one.
setopt hist_ignore_dups        # Don't record a command if it's a duplicate of the previous one.
setopt hist_ignore_space       # Don't record commands that start with a space.
setopt hist_reduce_blanks      # Remove superfluous blanks from history entries.
setopt hist_save_no_dups       # Don't save duplicate entries in the history file.
setopt inc_append_history      # Save history immediately after a command is run.
setopt interactive_comments    # Allow comments in an interactive shell.
setopt magic_equal_subst       # Enable filename expansion for commands like 'ls =.txt'.
setopt no_beep                 # Disable all audible terminal bells.
setopt no_hist_beep            # No beep on history navigation errors.
setopt no_list_beep            # No beep on completion list ambiguity.
setopt notify                  # Report status of background jobs immediately.
setopt print_eight_bit         # Display eight-bit characters correctly.
setopt print_exit_value        # Print exit value of programs that return non-zero.
setopt prompt_subst            # Allow substitutions in the prompt string.
setopt pushd_ignore_dups       # Don't push duplicate directories to the stack.
setopt share_history           # Share command history between all running shells.
setopt transient_rprompt       # Keep the right-side prompt only on the current line.

#==============================================================================
# ⌨️ ENHANCED KEY BINDINGS
#==============================================================================
# Set Emacs-style key bindings for line editing.
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

# Better history navigation with zsh-history-substring-search.
# Type part of a command, then press Up/Down to cycle through matches.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#==============================================================================
# 🔎 FZF CONFIGURATION
#==============================================================================
# Use 'fd' (a faster 'find' alternative) for fzf's file searching.
if command -v fd >/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#D5CED9,fg+:#D5CED9,bg:#23262E,bg+:#2e323d
    --color=hl:#7cb7ff,hl+:#00e8c6,info:#FFE66D,marker:#96E072
    --color=prompt:#f92672,spinner:#c74ded,pointer:#c74ded,header:#A0A1A7
    --color=border:#2e323d,label:#A0A1A7,query:#D5CED9
    --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
    --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
fi

# Apply fzf's default key bindings (Ctrl+T, Ctrl+R, Alt+C).
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#==============================================================================
# 👤 USER CONFIGURATION
#==============================================================================
# This section is for user-specific tools and environments.

# Powerlevel10k theme configuration.
# This file is generated by `p10k configure` and contains all visual settings for the prompt.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


