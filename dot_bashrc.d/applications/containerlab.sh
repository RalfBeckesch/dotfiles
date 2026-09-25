cmd=containerlab
if [ -n "$(command -v $cmd)" ];then
	alias clab='containerlab'
	source <(containerlab completion bash)
	complete -o default -F __start_containerlab clab
fi
