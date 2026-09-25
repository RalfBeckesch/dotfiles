#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

LINUXBREW_PATH="/home/linuxbrew/.linuxbrew"

if [ -d "$LINUXBREW_PATH" ];then
    debug "Found Homebrew, adding bin to path."
    PATH=$LINUXBREW_PATH/bin:$PATH
fi
