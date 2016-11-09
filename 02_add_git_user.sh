#!/usr/bin/env bash

echo "**********************************************************************"
echo "02_add_git_users.sh"

USR=$1
HOM=$2
printf "Creating user: $USR..."
sudo mkdir -p $HOM
sudo useradd -d $HOM $USR
sudo chown -R git:git $HOM