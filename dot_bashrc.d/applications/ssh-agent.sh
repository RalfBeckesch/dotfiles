
#
# Taken from Arch Wiki: https://wiki.archlinux.org/title/SSH_keys
#
# 	does it run for Debian/Ubuntu?
#
sshAgentEnv="$XDG_RUNTIME_DIR/ssh-agent.env"

if [ ! -e "${sshAgentEnv}" ]; then
	touch "${sshAgentEnv}"
fi

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 4h > "${sshAgentEnv}"
fi
if [ ! -f "$SSH_AUTH_SOCK" ]; then
    source "${sshAgentEnv}" >/dev/null
fi

