#!/usr/bin/env bash

# Kubernates installation follows: http://kubernetes.io/docs/getting-started-guides/ubuntu/

echo "********************************************************"
echo "kubernetes_master_setup.sh"

SYNCEDALLVMS=$1

OPTBIN="/opt/bin"
echo "adding $OPTBIN to PATH in /etc/profile (ie for all users, permanently)"
echo -e "\nPATH=$OPTBIN:\$PATH" >> /etc/profile

echo "ETCD: copying extracted binaries to /opt/bin"
mkdir -p $OPTBIN
cp $SYNCEDALLVMS/etcd-v2.0.0-linux-amd64/etcd* /opt/bin

SERVER_BIN=$SYNCEDALLVMS/kubernetes/server/kubernetes/server/bin
UBUNTU_MAS=$SYNCEDALLVMS/kubernetes/cluster/ubuntu/master

echo "Kubernetes: copying server/bin files to /opt/bin"
mkdir -p $OPTBIN
cp $SERVER_BIN/kube-apiserver $OPTBIN
cp $SERVER_BIN/kube-controller-manager $OPTBIN
cp $SERVER_BIN/kube-scheduler $OPTBIN
# cp $SERVER_BIN/kucecfg $OPTBIN
cp $SERVER_BIN/kubectl $OPTBIN
# cp $SERVER_BIN/kubernetes $OPTBIN

echo "Kubernetes: copying init_conf files to /etc/init"
mkdir -p /etc/init
cp $UBUNTU_MAS/init_conf/etcd.conf /etc/init
cp $UBUNTU_MAS/init_conf/kube-apiserver.conf /etc/init
cp $UBUNTU_MAS/init_conf/kube-controller-manager.conf /etc/init
cp $UBUNTU_MAS/init_conf/kube-scheduler.conf /etc/init

echo "Kubernetes: copying init_scripts files to /etc/init.d"
mkdir -p /etc/init.d
cp $UBUNTU_MAS/init_scripts/etcd /etc/init.d
cp $UBUNTU_MAS/init_scripts/kube-apiserver /etc/init.d
cp $UBUNTU_MAS/init_scripts/kube-controller-manager /etc/init.d
cp $UBUNTU_MAS/init_scripts/kube-scheduler /etc/init.d

## NB: the default scripts refered to below are not provided - I wrote them (so don't lose them!)
echo "Kubernetes: copying default_scripts to /etc/default"
mkdir -p /etc/default
cp $SYNCEDALLVMS/templates/master/default/etcd /etc/default
cp $SYNCEDALLVMS/templates/master/default/kube-apiserver /etc/default
cp $SYNCEDALLVMS/templates/master/default/kube-controller-manager /etc/default
cp $SYNCEDALLVMS/templates/master/default/kube-scheduler /etc/default