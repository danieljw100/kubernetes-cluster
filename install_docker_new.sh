#!/usr/bin/env bash

echo "********************************************************"
echo "install_docker_new.sh"

echo "Checking APT internal database for existing versions of docker-engine package"
apt-cache policy docker-engine

echo "Updating APT internal database from repository sources"
sudo apt-get update

#DOCKER_REPO_URL="deb https://apt.dockerproject.org/repo ubuntu-trusty main" # HTTPS URL
DOCKER_REPO_URL="deb http://apt.dockerproject.org/repo ubuntu-trusty main" # HTTP URL
DOCKER_SOURCES="/etc/apt/sources.list.d/docker.list"
echo "Adding $DOCKER_REPO_URL to $DOCKER_SOURCES"
echo "$DOCKER_REPO_URL" | sudo tee $DOCKER_SOURCES

KEY_SERVER="hkp://p80.pool.sks-keyservers.net:80"
#KEY_SERVER="hkp://ha.pool.sks-keyservers.net:80"
#KEY_SERVER="hkp://keyserver.ubuntu.com:80"
echo "Obtain docker repo GPG public key from key-server - and add to apt-key store"
sudo apt-key adv --keyserver $KEY_SERVER --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "Update local apt package index from remote repositories"
sudo apt-get update

echo "Verify that APT is pulling from the right repository"
apt-cache policy docker-engine

echo "Installing docker-engine"
sudo apt-get -y install docker-engine

echo "Creating docker user-group to allow docker commands to be run directly (ie without sudo) by selected users"
sudo groupadd docker
sudo usermod -aG docker vagrant
sudo usermod -aG docker xmen

echo "Checking Docker installation version"
sudo docker version

echo "Checking Docker upstart status"
sudo service docker status