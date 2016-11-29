#!/usr/bin/env bash

# Kubernates installation follows: http://kubernetes.io/docs/getting-started-guides/ubuntu/

echo "********************************************************"
echo "kubernetes_node_setup.sh"

SYNCEDALLVMS=$1
SERVER_BIN=$SYNCEDALLVMS/kubernetes/server/kubernetes/server/bin
UBUNTU_NOD=$SYNCEDALLVMS/kubernetes/cluster/ubuntu/minion

OPTBIN="/opt/bin"
echo "adding $OPTBIN to PATH in /etc/profile (ie for all users, permanently)"
echo -e "\nPATH=$OPTBIN:\$PATH" >> /etc/profile

echo "Kubernetes: copying binaries from downloaded/extracted archives into %OPTBIN"
mkdir -p $OPTBIN
cp $SERVER_BIN/kubelet $OPTBIN
cp $SERVER_BIN/kube-proxy $OPTBIN
# cp $SERVER_BIN/kucecfg $OPTBIN
cp $SERVER_BIN/kubectl $OPTBIN
# cp $SERVER_BIN/kubernetes $OPTBIN

echo "Kubernetes: copying .conf files from downloaded/extracted archives into /etc/init"
mkdir -p /etc/init
cp $SYNCEDALLVMS/templates/node/init_conf/kubelet.conf /etc/init #adapted to initialise on docker startup (instead of flannel)
# cp $UBUNTU_NOD/init_conf/kubelet.conf /etc/init
cp $SYNCEDALLVMS/templates/node/init_conf/kube-proxy.conf /etc/init #adapted to initialise on docker startup (instead of flannel)
# cp $UBUNTU_NOD/init_conf/kube-proxy.conf /etc/init

echo "Kubernetes: copying .sh scripts from downloaded/extracted archives into /etc/init.d"
mkdir -p /etc/init.d
cp $UBUNTU_NOD/init_scripts/kubelet /etc/init.d
cp $UBUNTU_NOD/init_scripts/kube-proxy /etc/init.d

## NB: the default scripts refered to below are not provided - I wrote them (so don't lose them!)
echo "Kubernetes: copying pre-created .sh defaults (from Vagrant project directory) into /etc/default"
mkdir -p /etc/default
cp $SYNCEDALLVMS/templates/node/default/kubelet /etc/default
cp $SYNCEDALLVMS/templates/node/default/kube-proxy /etc/default

# echo "Kubernetes: Starting node components..."
# echo "Kubernetes: checking component status BEFORE starting docker"
# initctl list | grep -E '(docker|kube)'
# echo "Kubernetes: re-starting docker"
# sudo service docker restart
# echo "Kubernetes: checking component status AFTER starting docker"
# initctl list | grep -E '(docker|kube)'