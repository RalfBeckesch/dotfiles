#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

if [ -n "$(command -v tv)" ];then
    debug "Completions 'tv'."
    eval "$(tv init bash)"
fi
