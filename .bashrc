# editor
export EDITOR=nvim

#path
export PATH="$PATH:./node_modules/.bin"

# aliases
alias be="bundle exec"

# mise
eval "$(~/.local/bin/mise activate bash)"

# prompt
PS1='\u@\h \w \[\e[36m\]$(git branch 2>/dev/null | sed -n "s/^* //p")\[\e[0m\] > '

# history
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth


# keybindings
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

# shell integration
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"

