#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})


if [ -n "$(command -v glow)" ]; then
	debug "Loading 'glow' completion."
	eval "$(glow completion bash)"
fi


