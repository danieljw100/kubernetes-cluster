#!/usr/bin/env bash

# Installs and configures Puppet as required for tutorial and demonstration
# As per book "Puppet 3" by John Arundel (p22-25)

echo "**********************************************************************"
echo "set_hostname_ip"

echo "Setting VM hostname"
hname=$1
sudo hostname $hname >/dev/null 2>&1
cmd1="sudo su -c 'echo $hname >/etc/hostname'"
eval $cmd1 >/dev/null 2>&1

echo "Adding VM IP address to /etc/hosts file"
IP=$(/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
cmd2="sudo su -c 'echo $IP $hname $hname.example.com >>/etc/hosts'"
eval $cmd2 >/dev/null 2>&1