#!/usr/bin/env bash

# Kubernates installation follows: http://kubernetes.io/docs/getting-started-guides/ubuntu/

echo "********************************************************"
echo "kubernetes_node_setup.sh"

SYNCEDALLVMS=$1

SERVER_BIN=$SYNCEDALLVMS/kubernetes/server/kubernetes/server/bin
UBUNTU_NOD=$SYNCEDALLVMS/kubernetes/cluster/ubuntu/minion

echo "Kubernetes: copying server/bin files to /opt/bin"
cp $SERVER_BIN/kubelet /opt/bin
cp $SERVER_BIN/kube-proxy /opt/bin
# cp $SERVER_BIN/kucecfg /opt/bin
cp $SERVER_BIN/kubectl /opt/bin
# cp $SERVER_BIN/kubernetes /opt/bin

echo "Kubernetes: copying init_conf files to /etc/init"
cp $UBUNTU_NOD/init_conf/kubelet.conf /etc/init
cp $UBUNTU_NOD/init_conf/kube-proxy.conf /etc/init

echo "Kubernetes: copying init_scripts files to /etc/init.d"
cp $UBUNTU_NOD/init_scripts/kubelet /etc/init.d
cp $UBUNTU_NOD/init_scripts/kube-proxy /etc/init.d

## NB: there is no default scripts directory !!!
# echo "Kubernetes: copying default_scripts files to /etc/default"
# cp $UBUNTU_NOD/default_scripts/kubelet /etc/default
# cp $UBUNTU_NOD/default_scripts/kube-proxy /etc/default