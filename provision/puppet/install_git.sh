#!/usr/bin/env bash

echo "**********************************************************************"
echo "install_git"

GIT_USER=$1
GIT_EMAIL=$2
SYNCEDTHISVM=$3
MASTER_IP=$4

sudo apt-get -y install git
echo "GIT version installed: $(git --version)"

echo "Setting global git configuration"
git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"
git config --global push.default matching

#TO-DO: Create short-hand command for cloning form the master bare-repo