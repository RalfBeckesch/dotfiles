#!/bin/bash

bashrcd_dir=~/.bashrc.d
host_specifics_dir=$bashrcd_dir/host_specifics

for i in $host_specifics_dir/*sh; do
	echo NOT include "'$i'"
done

