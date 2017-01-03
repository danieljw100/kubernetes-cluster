#!/usr/bin/env bash

# Starts the various node component processes in the correct order 
# NB - this could be more efficiently managed by setting the upstart dependencies for each job

echo "**********************************************************************"
echo "node_startup_sequence"

SYNCEDALLVMS=$1
NODENAME=$2

echo "ETCD: starting via upstart"
sudo service etcd start

snooze=15s
echo "Sleeping for $snooze (to allow etcd to start-up before publishing flannel network config)"
sleep $snooze
echo "Finished sleeping"

echo "Flannel: publishing network config to etcd key: /coreos.com/network/config"
sudo /opt/bin/etcdctl set /coreos.com/network/config '{"Network":"10.0.0.0/16", "SubnetLen": 24, "SubnetMin": "10.0.10.0", "SubnetMax": "10.0.90.0", "Backend": {"Type": "udp", "Port": 7890}}'

snooze=15s
echo "Sleeping for $snooze (to allow flannel to start-up before checking process an network status)"
sleep $snooze
echo "Finished sleeping"

echo "Flannel: starting via upstart"
sudo service flannel start

echo "Docker: reading flannel subnet and mtu variables"
sudo source /run/flannel/subnet.env

echo "Docker: updating /etc/default/docker with node specific --bip flag settings to correctly allocate IP subnet ranges to containers"
sudo cp $SYNCEDALLVMS/templates/node/default/docker_$NODENAME /etc/default && sudo mv /etc/default/docker_$NODENAME /etc/default/docker

echo "Docker: re-starting (with revised default --bip flag settings)"
sudo service docker restart
#sudo service docker stop
#sudo docker daemon --bip=${FLANNEL_SUBNET} --mtu=${FLANNEL_MTU} &