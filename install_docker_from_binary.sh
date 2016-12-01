#!/usr/bin/env bash

echo "********************************************************"
echo "install_docker_from_binary.sh"

BINARY_URL=$1
#Example BINARY_URL: https://get.docker.com/builds/Linux/x86_64/docker-1.11.0.tgz

echo "Downloading Docker binary at URL: $BINARY_URL"
sudo curl -L $BINARY_URL -o $SYNCEDALLVMS/docker-version.tgz >/dev/null 2>&1

echo "Extracting archive"
sudo tar -xvzf $SYNCEDALLVMS/docker-version.tgz -C $SYNCEDALLVMS

echo "Copying extracted files to /usr/bin"
sudo cp $SYNCEDALLVMS/docker/* /usr/bin

echo "Starting docker daemon"
sudo dockerd &

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