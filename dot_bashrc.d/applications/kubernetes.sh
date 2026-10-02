#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

cmd=kubectl
if [ -n "$(command -v $cmd)" ]; then
	debug "Loading $cmd completions and aliases."
	alias k='kubectl'
	source <(kubectl completion bash)
	complete -o default -F __start_kubectl k
	alias kgp='kubectl get pods'
	alias kc='kubectx'
	alias kn='kubens'
fi
