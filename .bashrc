# editor
export EDITOR=nvim

#path
export PATH="$PATH:./node_modules/.bin"

# prompt
# pure magic https://bash-prompt-generator.org/
PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'
PS1='\u@\h \W \[\e[36m\]${PS1_CMD1}\[\e[0m\] > '

# history
shopt -s histappend
HISTSIZE=20000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth

# autocomplete
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if command -v fzf &> /dev/null; then
  eval "$(fzf --bash)"
fi

# applicaiton init
eval "$(mise activate bash)"
