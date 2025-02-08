# editor
export EDITOR=nvim

#path
export PATH="$PATH:./node_modules/.bin"

# prompt
PS1='\u@\h \w \[\e[36m\]$(git branch 2>/dev/null | sed -n "s/^* //p")\[\e[0m\] > '

# input
set completion-prefix-display-length 2
set show-all-if-ambiguous on
set show-all-if-unmodified on
set mark-directories on
set match-hidden-files off
set page-completions off
set colored-stats on

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
  source /usr/share/bash-completion/completions/fzf
  source /usr/share/doc/fzf/examples/key-bindings.bash
fi

# applicaiton init
eval "$(mise activate bash)"
