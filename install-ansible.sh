#!/usr/bin/bash

sudo apt-get update -y

sudo apt-get install ansible -y

ansible-pull -U git@github.com:maikeru671/linuxconfiguration netplan-playbook.yaml


