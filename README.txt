ABOUT THIS PROJECT:
===================

This is a vagrant project that can be run on any Windows PC 
with vagrant and virtualbox installed

Basic usage: 
navigate to the cloned project directory and run "vagrant up" to
run a series of shell scripts to provision all of the components 
required to create a working kubernates cluster consisting of 
one virtual master/control-plane and two virtual nodes/minions. 
All virtual machine will be Linux Ubunty Trust64. The resulting 
environment can be used to sandbox kubernates and docker 
capabilities.

Advanced usage: 
the Vagrantfile can be adapted to allow an arbitrary number of nodes (subject to host cpapcity)