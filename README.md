# linuxconfiguration


This small project uses GitHub Actions and Ansible to move the existing netplan config file to the /tmp directory and replace it with the netplan config file from this repository on my EC2 instance.

I am still a beginner with Ansible and Github actions, but here is a quick overview of what these two technologies are to my understanding ( please feel free to offer any corrections if there are any misunderstandings):
- Ansible: Mainly used for Linux server configuration management, but, you can use it to provision Windows Servers, cisco switches, firewalls, and I've also seen it being used to configure servers such as Dell or even Cisco servers. I would say it's similar to what AWS SSM does.

- GitHub Actions: CI/CD platform. The reason I chose GitHub actions for this is so that when I make changes to bash scripts, code, etc I'd want to be able to have that change deployed to my IT infrastructure off of a git push. Or, if I make a change to a script for example, someone can look at it and verify all is good. If all is good, we can do a git push and it will deploy the change.

Here is a list of the contents in the github repo and what they are:
- install-ansible.sh (This bash script updates the EC2 instance, installs Ansible, and then does the ansible-pull command to execute the ansible playbook)
- netplan-config.yaml (This is the netplan config file that contains ip addressing information that I want to use on the EC2 instance)
- netplan-playbook.yaml (This is the ansible playbook)
- ./github/workflows/deploy.yml (This is the github actions code that connects to my EC2 instance and runs commands)

Here is a flow for how the above works ( we will assume that Ansible is not installed on the EC2 instance):

1. Do a git push from my local machine to the repo

2. The git push triggers GitHub actions, which does ssh to my EC2 instance. The EC2 hostname,  EC2 username, and SSH private key to access the instance are stored in Github scecrets.
(Note: it appears that when doing a git push, it clones the github repo to the home directory of the EC2 user. So if I write any bash scripts, ansible playbooks, etc, and put them into this repo, it will get stored in the /home/ubuntu directory on the EC2 instance).

3. After the ssh connection is made to the EC2 instance, the "install-ansible.sh" script in /home/ubuntu gets executed. I wrote the script and put it into this repo. This script does the following:
   A. sudo apt update -y
   B. sudo apt install ansible -y
   C. Runs the ansible-pull command.

4. The ansible-pull command executes the ansible playbook from my github repo. The playbook does the following:
   A. Moves the existing netplan config file from /etc/netplan to /tmp.
   B. Moves the desired netplan from /home/ubuntu to /etc/netplan.








