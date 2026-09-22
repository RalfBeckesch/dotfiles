#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

if [ -n "$(which chezmoi)" ];then
	debug "Adding chezmoi completion."
	source <(chezmoi completion bash)
fi
