#!/usr/bin/bash

sudo apt-get update -y

sudo apt-get install ansible -y

sudo ansible-pull -U https://github.com/maikeru671/linuxconfiguration.git netplan-playbook.yaml


