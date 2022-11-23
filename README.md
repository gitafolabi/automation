
## Features:

- A vagrantfile to Manage 3 VMs For Kubernertes Clusters (1 Control node and 2 worker nodes)
- Ansible playbook to automate the deployment the K8s clusters in the vagrant
- A simple Voting App deployed as containers into the kubernetes clusters
- Username and Password Encrypted and stored as Kubernetes Secrets
- Persistence DB with Persitence Volume and PVC
- Application Scalability provided by Horizontal Pod AutoScaler (HPA with minimum replica of 1 and Maximum Replicas of 4 with Metrics of cpuUtilization)
- GitHub Workflow to Manage Code Scanning (with CodeQL) before Merging Pull requests
- Infrastrucure Automation using Ansible (This is used to install all the dependencies for the k8s Clusters)

### Prerequisites

- A Linux workstation (I am using Ubuntu 20.10) with At least 8 GB of RAM and 15 GB of free hard disk space for the virtual machines.

> lsb_release -a

* Vagrant
> sudo apt install vagrant 

* VirtualBox
>sudo apt install virtualbox

* Ansible
>sudo apt-add-repository --yes --update ppa:ansible/ansible
>
>sudo apt install ansible

** File Structure

This code used to create a Kubernetes Cluster with Vagrant and Ansible is composed of:

- .vagrant/: Hidden directory for Vagrant tracking. It includes a Vagrant generated Inventory file: vagrant_ansible_inventory that is used by Ansible to match virtual machines and roles.
add_packages: Ansible playbook to install/remove packages using APT in an Ubuntu system.

- roles/

- common/: Installs the needed packages for Kubernetes (delegating in add_packages) and configures the common settings for Kubernetes master and nodes.

- k8s/master/: Ansible playbook to configure a Kubernetes master, it uses the common playbook for shared components between the Kubernetes master and the nodes.

- k8s/node/: Ansible playbook to configure a Kubernetes node, it uses the common playbook for shared components between the Kubernetes master and the nodes.

-  k8s.yml: Ansible playbook that uses the Kubernetes ansible roles.

- ditwl-k8s-01-join-command: this file is generated by the Kubernetes master and includes a temporary token and the command needed to join Kubernetes nodes to the cluster.

- Vagrantfile: contains the definition of the machines (CPU, memory, network and Ansible playbook and properties)

### To spin up the infrastructure run, clone this repo cd to the vagrant folder and vagrant up

>git clone https://github.com/avurlerby/automation.git 

>cd vagrant-ansible-infra && vagrant up

This will deploy vagrant and spin up the kubernetes clusters and configure the whole boostrapping using ansible

#### Kubernetes Network Overview

![Inkedansible-kubernetes-vagrant](https://user-images.githubusercontent.com/18261897/202597175-87a6f374-0938-43db-a3ad-5918ba862296.jpg)

After installing a Kubernetes Cluster it is recommended to:
-   Check the health of the cluster
-   Check networking status

Connect to kubernetes Cluster on the Vagrant

>ssh k8s-m-1

To check that all the necessary pods and services are running

>kubectl get pods –all-namespaces

List the Kubernetes cluster nodes using kubectl from your development host:
>kubectl cluster-info

Deploy the Voter Application Microservices
>kubectl create -f  /voting-app/k8s-specifications

This will deploy the voting app into the kubernetes clusters in the vagrant.

Check if the pods are running:

>kubectl get po -n vote


#### Thank you !
