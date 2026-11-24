#!/bin/bash
#
# Bootstrap chezmoi and apply the public dotfiles repository.
#
# Usage:
#   ./setup.sh
#
# Installs chezmoi if missing, then initializes and applies the public
# dotfiles from git.beckesch.it:beckesch/dotfiles.git.

set -euo pipefail

readonly local_bin="${HOME}/.local/bin"
readonly public_repo="git@git.beckesch.it:beckesch/dotfiles.git"

# --
# 1. Install chezmoi if missing
# --
if ! command -v chezmoi >/dev/null; then
  mkdir -p "$local_bin"
  /bin/sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$local_bin" init --apply "$public_repo"
fi

# --
# 2. Init/apply the public dotfiles repo
# --
if ! chezmoi source-path >/dev/null 2>&1; then
  chezmoi init "$public_repo"
fi
chezmoi apply