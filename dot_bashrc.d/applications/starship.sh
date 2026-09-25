#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

if [ -n "$(command -v starship)" ]; then
    debug "Loading starship completion."
    eval "$(starship init bash)"
fi
