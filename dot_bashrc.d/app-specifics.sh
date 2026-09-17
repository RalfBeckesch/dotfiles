#!/bin/bash

bashrcd_dir=~/.bashrc.d
app_specifics_dir=$bashrcd_dir/app_specifics

for i in $app_specifics_dir/*sh; do
    echo . $i
done

