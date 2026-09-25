#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

debug "Adding cd 'dot dot dot..' aliases."

## a quick way to get out of current directory ##
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
