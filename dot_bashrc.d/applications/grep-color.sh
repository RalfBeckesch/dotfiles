#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})


if [ -n "$(command -v grep)" ]; then
	debug "Colorizing grep."
	alias grep='grep --color=auto'
fi

if [ -n "$(command -v egrep)" ]; then
	debug "Colorizing egrep."
	alias egrep='egrep --color=auto'
fi

if [ -n "$(command -v fgrep)" ]; then
	debug "Colorizing fgrep."
	alias fgrep='fgrep --color=auto'
fi

