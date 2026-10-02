#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

cmd=sbx
if [ -n "$(command -v $cmd)" ]; then
	debug "Loading '$cmd' completion."
	source <($cmd completion bash)
fi
