#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})

cmd=docker
if [ -z "$(command -v $cmd)" ]; then
	return
fi
debug "Loading '$cmd' completion."
source <($cmd completion bash)

function docker-show-mounts () {
	C="$1"
	docker inspect "$C" --format '{{range .Mounts}}{{println .Source "->" .Destination}}{{end}}'
}

