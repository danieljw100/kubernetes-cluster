#!/usr/bin/env bash

echo "**********************************************************************"
echo "08_identify_nodes.sh"

echo "Copying user:git .ssh directory from master to node"
echo "(this will permit git@node to login as git@master - required in order to clone the puppet repo)"
su git -c 'cp -R /vagrant/synced/allvms/.ssh ~/.ssh'
su git -c 'chmod 600 ~/.ssh/id_rsa'
su git -c 'chmod 644 ~/.ssh/authorized_keys ~/.ssh/id_rsa.pub'
# notify the ssh-agent to use this id for git user
su git -c 'eval `ssh-agent -s` && ssh-add ~/.ssh/id_rsa'

echo "Adding master server ECDSA public key to nodes known_hosts file"
echo "(this will permit ssh authentication from node to master with StrictHostChecking=yes)"
MASTER_IP=$1
cmd1="su git -c 'ssh-keyscan $MASTER_IP | grep ecdsa-sha2-nistp256 > ~/.ssh/known_hosts'"
eval $cmd1
#su git -c 'ssh-keyscan $MASTER_IP | grep ecdsa-sha2-nistp256 > ~/.ssh/known_hosts'
# Hashing known_hosts file (this converts the plain text addresses to a sha hash, indexes the entries and sets the file permissions correctly)
echo "Hashing known_hosts entries..."
su git -c 'ssh-keygen -H'
echo "Removing obselete file: known_hosts.old"
su git -c 'rm -rf /home/git/.ssh/known_hosts.old'