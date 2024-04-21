# editor
export EDITOR=nvim

# path
export PATH="$PATH:$HOME/go/bin/"

# aliases
alias be="bundle exec"
alias kc="kubectl"

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
