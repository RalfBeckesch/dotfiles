#!/bin/sh
exec chezmoi \
  --config "$HOME/.config/chezmoi-private/chezmoi.toml" \
  --source "$HOME/.local/share/chezmoi-private" \
  "$@"
