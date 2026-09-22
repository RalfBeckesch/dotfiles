#!/bin/bash

local_bin=$HOME/.local/bin  

PATH=$PATH:/bin

set -euo pipefail

#  
# Install "chezmoi" if not installed  
#  
if ! command -v chezmoi >/dev/null; then  
	/bin/sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $local_bin init --apply git@git.beckesch.it:beckesch/dotfiles.git 
fi
