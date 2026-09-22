#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})


debug "Adding mkdir aliases."

# Create parent directories on demand
alias mkdir='mkdir -pv'
