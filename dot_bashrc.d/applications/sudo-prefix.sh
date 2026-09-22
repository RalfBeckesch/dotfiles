#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

function alias_prefix_sudo_if_exists() {
    cmd="$1"
    shift
    opts="$*"
    debug "cmd='$cmd' opt='$opts'"
    if [ -n "$(command -v $cmd)" ]; then
        alias $cmd="sudo $cmd $opts"
    fi
}

if [ $UID -ne 0 ]; then
    debug "I am not 'root'."
    if [ -n "$(command -v sudo)" ]; then
        debug "sudo is installed."
        alias_prefix_sudo_if_exists reboot
        alias_prefix_sudo_if_exists apt-get
        alias_prefix_sudo_if_exists pacman
        alias_prefix_sudo_if_exists dnf
        alias_prefix_sudo_if_exists zypper
    fi
fi
