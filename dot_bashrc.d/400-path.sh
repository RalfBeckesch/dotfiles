#!/bin/bash


# Rancher Desktop
if [ -d "$HOME/.rd/bin" ]; then
	PATH=$HOME/.rd/bin:$PATH
fi

# Rancher Desktop
if [ -d "$HOME/bin" ]; then
	PATH=$HOME/bin:$PATH
fi


# Local installed binaries
PATH=$HOME/.local/bin:$PATH
