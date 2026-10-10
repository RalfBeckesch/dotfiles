#!/bin/bash
scriptname=$(basename ${BASH_SOURCE[0]})
scriptdirname=$(dirname ${BASH_SOURCE[0]})


bashrcd_dir=~/.bashrc.d
applications_dir=$bashrcd_dir/applications

for i in $applications_dir/*sh; do

	debug "include '$i'"
	if [ -n "$DEBUG" ]; then		
		start_ns=$(date +%s%N)
	fi

	. $i

	if [ -n "$DEBUG" ]; then
		end_ns=$(date +%s%N)
		elapsed_ns=$((end_ns - start_ns))
		elapsed_s=$(awk -v ns="$elapsed_ns" 'BEGIN {printf "%.9f", ns / 1000000000}')
	fi


	debug "\n\t---\n\t--- Dauer: '$i' \n\t---"
	debug '\t---\t'$(printf '%s s (%d ns)\n' "$elapsed_s" "$elapsed_ns")
	debug '\t---'

done

