ABOUT THIS PROJECT:
===================

This projects extends the basic cluster v1.0 tag (which creates a master node cluster with an common ssh authenticated user on each machine).

Specifically it adds puppet set-up to all machines that is it
 - installs git and puppet on all machnes
 - establishes a common puppet directory location into which manifests will be git cloned 
 - creates a short-hand papply command to allow the puppet apply commnd to be run from anywhere without the user having to specify the other parameters

This results in a cluster that can be further extended via deployments using puppet manifests that are distrubuted from master to nodes via git.
(NB: Using git, this way,to distribute puppet manifests is the alterative to using the puppets native puppetmaster)

