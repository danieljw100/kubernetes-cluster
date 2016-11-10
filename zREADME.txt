ABOUT THIS PROJECT:
===================

This vagrant project provisions an environment that contains the following vms:
 - 1 x master
 - N x nodes

It creates a common ssh_user (of chosen username) on all vms and configures all of the vms with the same shared ssh configuration including known_hosts, authorized users, ssh_user private and public keys.

This allows all vm to ssh to all other vms as the ssh_user.

BEFORE YOU RUN THIS PROJECT:
============================

The first few lines of the Vagrantfile contain variables that you should configure - according to how you want the environment set-up (eg names and numbers of nodes etc...)

To prevent any start-up issues remove any vestigial directories from the vagrant project directory - incuding directories: all, master, node01, etc and .vagrant

