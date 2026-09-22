#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

debug "Setup bash config."

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth


# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=50000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

BASH_ALIASES="~/.bash_aliases"
if [ -f "$BASH_ALIASES" ]; then
    debug "Loading '$BASH_ALIASES'."
    . $BASH_ALIASES
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    BASH_COMPLETION=/usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    BASH_COMPLETION=/etc/bash_completion
  fi
  if [ -n "$BASH_COMPLETION" ]; then
    debug "Loading bash completion '$BASH_COMPLETION'."
    . $BASH_COMPLETION
  fi
fi





