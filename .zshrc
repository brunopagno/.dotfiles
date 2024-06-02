# editor
export EDITOR=nvim

# path
export PATH="$PATH:$HOME/go/bin:$HOME/.cargo/bin"

# aliases
alias be="bundle exec"
alias kc="kubectl"
alias tlt="/usr/bin/tilt"
alias ls="ls --color"

# asdf-vm
. "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)

# autoload
autoload -Uz compinit promptinit
compinit
promptinit

# prompt
prompt redhat

# completion
zstyle ':completion:*' menu select

# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

unsetopt autocd beep

bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# shell integration
eval "$(fzf --zsh)"
