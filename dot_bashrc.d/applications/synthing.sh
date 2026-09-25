#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

if [ -n "$(command -v syncthing)" ]; then
	debug "Installing 'syncthing' completions"
	syncthing install-completions
fi
