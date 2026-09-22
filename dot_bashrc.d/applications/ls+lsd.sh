#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

if [ -n "$(which lsd)" ];then
    debug "Using 'lsd'."
	ls='lsd'
else
    debug "Using standard 'ls'."
    alias ls='ls --color=auto'
fi
alias l='ls -l'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
