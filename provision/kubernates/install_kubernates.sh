#!/usr/bin/env bash

# Kubernates installation follows: http://kubernetes.io/docs/getting-started-guides/ubuntu/

echo "********************************************************"
echo "install_kubernates.sh"

SYNCEDTHISVM=$1

# DOWNLOAD KUBERNATES BINARIES
wget -O $SYNCEDTHISVM "https://github.com/kubernetes/kubernetes/releases/download/v1.4.6/kubernetes.tar.gz"
tar -xf $SYNCEDTHISVM/kubernetes.tar.gz -C $SYNCEDTHISVM


# KUBECTL SET-UP 
# KUBECTL will be used subsequently to bootstrap remianing components on both the controller and worker nodes
# EITHER move kubectl binaries into /usr/local/bin/kubectl (which is already on the system class PATH) and make executable
sudo cp $SYNCEDTHISVM/kubernetes/platforms/linux/amd64/kubectl /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl
# OR add existing binary file location directly to PATH
#export PATH=$SYNCEDTHISVM/kubernetes/platforms/linux/amd64:$PATH

