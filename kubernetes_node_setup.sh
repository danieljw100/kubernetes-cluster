#!/usr/bin/env bash

# Kubernates installation follows: http://kubernetes.io/docs/getting-started-guides/ubuntu/

echo "********************************************************"
echo "kubernetes_node_setup.sh"

SYNCEDALLVMS=$1

OPTBIN="/opt/bin"
echo "adding $OPTBIN to PATH in /etc/profile (ie for all users, permanently)"
echo -e "\nPATH=$OPTBIN:\$PATH" >> /etc/profile

SERVER_BIN=$SYNCEDALLVMS/kubernetes/server/kubernetes/server/bin
UBUNTU_NOD=$SYNCEDALLVMS/kubernetes/cluster/ubuntu/minion

echo "Kubernetes: copying server/bin files to /opt/bin"
mkdir -p $OPTBIN
cp $SERVER_BIN/kubelet $OPTBIN
cp $SERVER_BIN/kube-proxy $OPTBIN
# cp $SERVER_BIN/kucecfg $OPTBIN
cp $SERVER_BIN/kubectl $OPTBIN
# cp $SERVER_BIN/kubernetes $OPTBIN

echo "Kubernetes: copying init_conf files to /etc/init"
mkdir -p /etc/init
cp $UBUNTU_NOD/init_conf/kubelet.conf /etc/init
cp $UBUNTU_NOD/init_conf/kube-proxy.conf /etc/init

echo "Kubernetes: copying init_scripts files to /etc/init.d"
mkdir -p /etc/init.d
cp $UBUNTU_NOD/init_scripts/kubelet /etc/init.d
cp $UBUNTU_NOD/init_scripts/kube-proxy /etc/init.d

## NB: the default scripts refered to below are not provided - I wrote them (so don't lose them!)
echo "Kubernetes: copying default_scripts to /etc/default"
mkdir -p /etc/default
cp $SYNCEDALLVMS/templates/node/default/kubelet /etc/default
cp $SYNCEDALLVMS/templates/node/default/kube-proxy /etc/default