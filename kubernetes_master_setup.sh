#!/usr/bin/env bash

# Kubernates installation follows: http://kubernetes.io/docs/getting-started-guides/ubuntu/

echo "********************************************************"
echo "kubernetes_master_setup.sh"

SYNCEDALLVMS=$1

echo "ETCD: copying extracted binaries to /opt/bin"
mkdir -p /opt/bin
cp $SYNCEDALLVMS/etcd-v2.0.0-linux-amd64/etcd* /opt/bin

SERVER_BIN=$SYNCEDALLVMS/kubernetes/server/kubernetes/server/bin
UBUNTU_MAS=$SYNCEDALLVMS/kubernetes/cluster/ubuntu/master

echo "Kubernetes: copying server/bin files to /opt/bin"
cp $SERVER_BIN/kube-apiserver /opt/bin
cp $SERVER_BIN/kube-controller-manager /opt/bin
cp $SERVER_BIN/kube-scheduler /opt/bin
# cp $SERVER_BIN/kucecfg /opt/bin
cp $SERVER_BIN/kubectl /opt/bin
# cp $SERVER_BIN/kubernetes /opt/bin

echo "Kubernetes: copying init_conf files to /etc/init"
cp $UBUNTU_MAS/init_conf/etcd.conf /etc/init
cp $UBUNTU_MAS/init_conf/kube-apiserver.conf /etc/init
cp $UBUNTU_MAS/init_conf/kube-controller-manager.conf /etc/init
cp $UBUNTU_MAS/init_conf/kube-scheduler.conf /etc/init

echo "Kubernetes: copying init_scripts files to /etc/init.d"
cp $UBUNTU_MAS/init_scripts/etcd /etc/init.d
cp $UBUNTU_MAS/init_scripts/kube-apiserver /etc/init.d
cp $UBUNTU_MAS/init_scripts/kube-controller-manager /etc/init.d
cp $UBUNTU_MAS/init_scripts/kube-scheduler /etc/init.d

## NB: there is no default scripts directory !!!
# echo "Kubernetes: copying default_scripts files to /etc/default"
# cp $UBUNTU_MAS/default_scripts/etcd /etc/default
# cp $UBUNTU_MAS/default_scripts/kube-apiserver /etc/default
# cp $UBUNTU_MAS/default_scripts/kube-controller-manager /etc/default
# cp $UBUNTU_MAS/default_scripts/kube-scheduler /etc/default

