#!/usr/bin/env bash

echo "********************************************************"
echo "install_docker_pre-reqs.sh"

echo "Running Docker prerequisites for Ubuntu Trusty 14.04 (LTS)..."

sudo apt-get update

echo "Installing apt-transport-https and ca-certificates (to ensure that apt works with https)"
sudo apt-get -y install apt-transport-https ca-certificates

echo "Installing linux-image-extra-* kernel packages"
sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual

echo "Creating docker user-group to allow docker commands to be run without sudo"
sudo groupadd docker
sudo usermod -aG docker $USER