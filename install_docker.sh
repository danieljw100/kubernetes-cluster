#!/usr/bin/env bash

echo "********************************************************"
echo "install_docker.sh"

echo "Update local apt package index from remote repositories specified in /etc/apt/sources.list and /etc/apt/sources.list.d/"
sudo apt-get update

echo "Install apt-transport-https and ca-certificates (to ensure that apt works with https)"
sudo apt-get -y install apt-transport-https ca-certificates

KEY_SERVER="hkp://p80.pool.sks-keyservers.net:80"
#KEY_SERVER="hkp://ha.pool.sks-keyservers.net:80"
#KEY_SERVER="hkp://keyserver.ubuntu.com:80"
echo "Update local apt-key manager"
sudo apt-key update
echo "Obtain docker repo GPG public key from key-server - and add to apt-key store"
sudo apt-key adv --keyserver $KEY_SERVER --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

#DOCKER_REPO_URL="deb https://apt.dockerproject.org/repo ubuntu-trusty main" # HTTPS URL
DOCKER_REPO_URL="deb http://apt.dockerproject.org/repo ubuntu-trusty main" # HTTP URL
echo "Docker repo URL: $DOCKER_REPO_URL"
echo "***WARNING***: if you're using an http URL your docker repo might be served-up from a man-in-the-middle!"
echo "Adding Docker repo URL to /etc/apt/sources.list.d/docker.list"
echo "$DOCKER_REPO_URL" | sudo tee /etc/apt/sources.list.d/docker.list

echo "Update local apt package index from remote repositories"
sudo apt-get update

echo "Verify that APT is pulling from the right repository"
apt-cache policy docker-engine

echo "Running Docker prerequisites for Ubuntu Trusty 14.04 (LTS)..."

echo "Update local apt package index from remote repositories"
sudo apt-get update

echo "Install linux-image-extra-* kernel packages"
sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual

echo "Installing Docker"
sudo apt-get update
sudo apt-get -y install docker-engine
sudo service docker start

echo "Running hello-world image (with sudo) to test Docker installation"
sudo docker run hello-world

echo "Creating docker user-group to allow docker commands to be run without sudo"
sudo groupadd docker
sudo usermod -aG docker $USER

echo "Re-Running hello-world image (with sudo) to test Docker installation"
sudo docker run hello-world

echo "Re-Running hello-world image (without sudo) to test Docker installation"
docker run hello-world

echo "install_docker.sh: COMPLETE"
echo "NB: need to logout then back in again for docker group changes to take effect"