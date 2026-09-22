#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

if  [ -n "$(command -v nvim)" ]; then
    alias vi='nvim'
elif [ -n "$(command -v vim)" ]; then
    alias vi='vim'
fi

debug "Added 'vi' aliased: $(alias | grep vi)"

