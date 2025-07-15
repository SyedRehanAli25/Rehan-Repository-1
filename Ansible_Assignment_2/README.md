# Ansible Assignment 2 – Web Server Automation

##  Objective

Automate the deployment of web infrastructure across two EC2 instances using Ansible. This includes:

- Installing and configuring **Nginx** and **Apache**
- Setting up log rotation to limit Nginx logs to 1 GB
- Creating 3 websites (for team members: Rehan, Harsh, Prakash)
- Rotating displayed websites every 2 hours
- Configuring Nginx as a reverse proxy to Apache
- Applying playbooks one node at a time using `serial` and Ansible strategies

---

##  Team Members
- Rehan
- Harsh
- Prakash

---

##  Repository Structure
Ansible_Assignment_2/
├── README.md
├── hosts.ini
├── nginx_log_rotation.yml
├── website_rotation.yml
├── files/
│ └── rotate_site.sh


---

##  Inventory (`hosts.ini`)

[web]
web1 ansible_host=172.31.8.202 ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/my_ubuntu.pem
web2 ansible_host=172.31.15.146 ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/my_ubuntu.pem
 Playbooks

nginx_log_rotation.yml
Installs Nginx and logrotate
Ensures log rotation for /var/log/nginx/*.log
Configured to rotate when logs exceed 1 GB
website_rotation.yml
Creates 3 websites under /var/www/
Generates index.html with unique content for each member
Installs cron job to switch websites every 2 hours using rotate_site.sh
 Strategies

Uses serial: 1 to apply changes one node at a time
Ensures controlled and reliable configuration
 Cron-based Website Rotation

The file rotate_site.sh rotates between sites every 2 hours by updating the Nginx root symlink and reloading the service.

 Prerequisites

Ensure both EC2 nodes are reachable via SSH
Provide correct private key path and user in hosts.ini
Use Ansible version 2.10+ recommended
 Run Instructions

ansible -i hosts.ini web -m ping
ansible-playbook -i hosts.ini nginx_log_rotation.yml
ansible-playbook -i hosts.ini website_rotation.yml

