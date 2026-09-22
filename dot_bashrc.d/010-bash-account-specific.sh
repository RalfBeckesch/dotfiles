#!/bin/bash

#
# This file could include for example
#
#   export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"


bash_account_specific="$HOME/.bashrc_for_this_user"

if [ -f "$bash_account_specific" ]; then
    debug "Include '"$bash_account_specific"'."
    . $bash_account_specific
fi






