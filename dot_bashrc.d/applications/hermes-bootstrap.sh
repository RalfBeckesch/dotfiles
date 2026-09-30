#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

# In ~/.local/share/chezmoi/setup.sh oder ~/.bashrc.d/hermes.sh
if command -v hermes >/dev/null 2>&1; then
  # auto_load nur setzen wenn noch nicht vorhanden
  if ! hermes config get skills.auto_load --json 2>/dev/null | grep -q rechner-setup; then
    hermes config set skills.auto_load '["rechner-setup"]'
    debug "hermes: skill 'rechner-setup' automatisch laden konfiguriert."
    return
  fi
  debug "hermes: skill 'rechner-setup' wird bereits automatisch geladen."
fi
