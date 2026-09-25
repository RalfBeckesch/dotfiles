#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

debug "Adding 'date' aliases."

alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
