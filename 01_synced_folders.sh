#!/usr/bin/env bash

echo "**********************************************************************"
echo "01_synced_folders.sh"

array=( "$@" )
for i in "${array[@]}"
do
	sudo mkdir -p $i
	echo " - created: $i"
done