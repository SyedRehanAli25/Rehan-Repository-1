
#  Ansible Assignment-5 — Kubernetes Role Installer (by Rehan - DevOps Titans)

##  Objective

Create an OS-independent Ansible role to:
- Install a specific version of Kubernetes
- Support Ubuntu (and optionally CentOS)
- Use Jinja templates for configuration
- Separate handlers from tasks
- Use variable-driven configuration

---

##  Role: `kube_installer`

### Features:
- Installs Kubernetes components: `kubeadm`, `kubelet`, `kubectl`
- Uses the secure official Kubernetes APT repo
- Manages GPG keyring
- Uses handlers to restart `kubelet` on config changes
- Supports dynamic configuration using templates

---

## ️ Inventory

**File:** `inventory.ini`

```ini
[ubuntu]
ubuntu-node ansible_host=51.20.92.229 ansible_user=ubuntu ansible_ssh_private_key_file=/Users/syedrehan/Downloads/New_Ubuntu.pem
Playbook

File: playbook.yml

- name: Install Kubernetes with kube_installer role
  hosts: ubuntu
  become: true
  roles:
    - kube_installer
 Directory Structure

Ansible_Assignment-5/
├── inventory.ini
├── playbook.yml
├── README.md
└── roles/
    └── kube_installer/
        ├── defaults/
        ├── handlers/
        ├── tasks/
        ├── templates/
        └── vars/
 Variables

roles/kube_installer/defaults/main.yml

kubernetes_version: "1.29.0"
Jinja Template

templates/kube_config.j2

apiVersion: v1
kind: Config
preferences: {}
clusters:
  - cluster:
      server: "https://{{ ansible_host }}:6443"
    name: "kubernetes"
contexts:
  - context:
      cluster: "kubernetes"
      user: "admin"
    name: "kubernetes-context"
current-context: "kubernetes-context"
users:
  - name: "admin"
    user:
      token: "{{ kube_token | default('dummy-token') }}"
 Handler

handlers/main.yml

- name: Restart kubelet
  service:
    name: kubelet
    state: restarted
 Run

ansible-playbook -i inventory.ini playbook.yml

# Ansible Assignment 1

**Team Name:** DevOps Titans  
**Team Members:** Rehan, Harsh, Prakash

This assignment demonstrates the use of Ansible ad hoc commands to:
- Manage users and groups
- Set directory permissions
- Create shared folders (`Team` and `Ninja`)
- Change shell and password
- <img width="1440" height="900" alt="image" src="https://github.com/user-attachments/assets/24a9b543-8a0c-4ba6-9ac7-5239926a7ef2" />

- Delete users and groups
- <img width="1440" height="900" alt="image" src="https://github.com/user-attachments/assets/b2bd1ac6-8ddb-4ff6-bcab-57038fa1f129" />

- List system users and groups

Controller and target were the same EC2 instance (`localhost` with `ansible_connection=local`).
>>>>>>> a1dafcabc4473cd5bf575a56e1b2baa4bc8aa096
