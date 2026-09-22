#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

function debug () {
    if [ -n "$DEBUG" ]; then
        echo -e "$*" >&2
    fi
}

debug "Colorizing grep aliases."

## Colorize the grep command output for ease of use (good for log files)##

if [ -n "$(command -v grep)" ]; then
    alias grep='grep --color=auto'
fi

if [ -n "$(command -v grep)" ]; then
    alias egrep='egrep --color=auto'
fi

if [ -n "$(command -v grep)" ]; then
    alias fgrep='fgrep --color=auto'
fi

