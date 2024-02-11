# editor
export EDITOR=nvim

# aliases
alias be="bundle exec"

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
SAVEHIST=10000
unsetopt autocd beep
bindkey -v
