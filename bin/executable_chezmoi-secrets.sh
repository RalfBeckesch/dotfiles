#!/bin/sh
exec chezmoi \
--config "$HOME/.config/chezmoi-secrets/chezmoi.toml" \
--source "$HOME/.local/share/chezmoi-secrets" \
--persistent-state "$HOME/.config/chezmoi-secrets/chezmoistate.boltdb" \
"$@"

