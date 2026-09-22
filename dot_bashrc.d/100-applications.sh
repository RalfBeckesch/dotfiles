#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})


bashrcd_dir=~/.bashrc.d
applications_dir=$bashrcd_dir/applications

for i in $applications_dir/*sh; do
	debug "include '$i'"
	. $i
done

