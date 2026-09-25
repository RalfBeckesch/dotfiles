cmd=kubectl
if [ -n "$(command -v $cmd)" ]; then
	alias k='kubectl'
	source <(kubectl completion bash)
	complete -o default -F __start_kubectl k
	alias kgp='kubectl get pods'
	alias kc='kubectx'
	alias kn='kubens'
fi
