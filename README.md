# Kubernetes Home Lab with Ansible

This repository contains Ansible playbooks and roles for setting up a Kubernetes home lab. It's designed for testing purposes.

## Cluster Setup

- **Master Node**: Hosts the control plane components.
- **Worker Node**: Runs workloads.
- **Pod Scheduling**: Pods will be scheduled and run on both the master and worker nodes, allowing you to test and experiment with various deployment scenarios.

## Requirements

- Ansible installed on your control machine.
- Two target nodes (or virtual machines) configured as:
  - One master node
  - One worker node
- SSH access and sudo privileges on the target nodes.
- Proper network connectivity between the nodes.

## Running the Playbook

To set up the Kubernetes home lab, run the following command:

```sh
ansible-playbook -i inventory.ini k8s_lab_setup.yml -K -u <YOUR_USER>
```

Replace `<YOUR_USER>` with your actual username.
