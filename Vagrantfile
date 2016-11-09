# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # VM SYNCED DIRECTORIES
  SYNCEDALLVMS = "/vagrant/synced/allvms"
  SYNCEDTHISVM = "/vagrant/synced/thisvm"

  # ALL VMs
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder "./all", "#{SYNCEDALLVMS}", :create => true       #create HOST dir (if reqd)
  config.vm.provision "shell", path: "01_synced_folders.sh", args: ["#{SYNCEDALLVMS}", "#{SYNCEDTHISVM}"]
  config.vm.provision "shell", path: "02_add_git_user.sh", args: ["git", "/home/git"]

  # MASTER VM ONLY
  MASTER = "master"
  MASTER_IP = "172.28.128.6"
  config.vm.define "#{MASTER}" do |ma|
    ma.vm.provider "virtualbox" do |vb|
      vb.name = "#{MASTER}"
    end
    ma.vm.network "private_network", ip: "#{MASTER_IP}"
    ma.vm.synced_folder "./master", "#{SYNCEDTHISVM}", :create => true      #create HOST dir (if reqd)
    ma.vm.provision "shell", path: "04_set_hostname_and_IP.sh", args: ["#{MASTER}"]
    ma.vm.provision "shell", path: "07_generate_user_keys.sh"
  end

  # NODE VMs ONLY
  (1..2).each do |i|
    config.vm.define "node0#{i}" do |nd|
      nd.vm.provider "virtualbox" do |vb|
        vb.name = "node0#{i}"
      end  
      nd.vm.network "private_network", type: "dhcp"
      nd.vm.synced_folder "./node0#{i}", "#{SYNCEDTHISVM}", :create => true #create HOST dir (if reqd)
      nd.vm.provision "shell", path: "04_set_hostname_and_IP.sh", args: ["node0#{i}"]
      nd.vm.provision "shell", path: "08_identify_node.sh", args: ["#{MASTER_IP}"]
    end
  end

end