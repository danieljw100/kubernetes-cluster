This vagrant project provisions an environment that contains the following vms:
 - 1 x master
 - N x nodes

It creates a common user (of chosen username) on all vms and shres the private key amongst all vms to allow all vm to ssh into all other vms as that user
