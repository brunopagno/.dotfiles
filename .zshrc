# editor
export EDITOR=nvim

# path
export PATH="$PATH:$HOME/go/bin"

# aliases
alias be="bundle exec"
alias kc="kubectl"
alias ls="ls --color"

# asdf-vm
. "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)

# autoload
autoload -Uz compinit promptinit vcs_info
compinit
promptinit
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# completion
zstyle ':completion:*' menu select

# prompt
# prompt redhat
RPROMPT='${vcs_info_msg_0_}'
PROMPT="%n@%m %1~ > "
zstyle ':vcs_info:git:*' formats '%b'

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
