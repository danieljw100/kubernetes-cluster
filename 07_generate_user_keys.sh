#!/usr/bin/env bash

echo "**********************************************************************"
echo "07_generating_user_keys.sh"

su git -c 'mkdir -p ~/.ssh'
su git -c 'ssh-keygen -t rsa -b 4096 -C "<email>" -f ~/.ssh/id_rsa'

echo "Adding newly generated public key to authorized_users file..."
su git -c 'cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys'

echo "Copying .shh directory to common synced folders (to allow subsequent nodes to obtain it)..."
su git -c 'cp -R ~/.ssh /vagrant/synced/allvms/'