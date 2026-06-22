📘 Azure Load Balancer High‑Availability Web App (Project 2)
This project demonstrates a high‑availability web application architecture using an Azure Public Load Balancer distributing traffic across multiple virtual machines. It showcases core Azure networking and compute concepts used in real production environments.

🌍 Architecture Overview
This solution deploys:

A Public Load Balancer

A backend pool of 3 web servers (VM1, VM2, VM3)

A Virtual Network with a dedicated Web Subnet

A Network Security Group (NSG) with HTTP + SSH rules

A simple web app running on each VM

This architecture supports:

High availability

Horizontal scaling

Fault tolerance

Load distribution across multiple VMs

The full diagram is available in:
architecture/lb-diagram.mmd

🏗 Components
1. Public Load Balancer
Distributes incoming traffic across VMs

Uses a health probe to detect healthy instances

Exposes port 80 to the internet

2. Backend Pool
VM1, VM2, VM3

Each runs a simple web server

3. Virtual Network
One VNet

One Web Subnet

4. Network Security Group
Allow HTTP (80)

Allow SSH (22)

🚀 Deployment Steps (Azure CLI)
1. Create Resource Group
bash
az group create -n rg-loadbalancer -l uksouth
2. Create VNet + Subnet
bash
az network vnet create \
  -g rg-loadbalancer \
  -n vnet-web \
  --address-prefix 10.0.0.0/16 \
  --subnet-name web-subnet \
  --subnet-prefix 10.0.1.0/24
3. Create Public IP
bash
az network public-ip create \
  -g rg-loadbalancer \
  -n lb-pip \
  --sku Standard
4. Create Load Balancer
bash
az network lb create \
  -g rg-loadbalancer \
  -n web-lb \
  --sku Standard \
  --public-ip-address lb-pip \
  --frontend-ip-name web-frontend \
  --backend-pool-name web-backend
5. Create Health Probe
bash
az network lb probe create \
  -g rg-loadbalancer \
  --lb-name web-lb \
  -n web-probe \
  --protocol tcp \
  --port 80
6. Create LB Rule
bash
az network lb rule create \
  -g rg-loadbalancer \
  --lb-name web-lb \
  -n http-rule \
  --protocol tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name web-frontend \
  --backend-pool-name web-backend \
  --probe-name web-probe
7. Deploy 3 VMs
bash
for i in 1 2 3
do
  az vm create \
    -g rg-loadbalancer \
    -n vm$i \
    --image UbuntuLTS \
    --vnet-name vnet-web \
    --subnet web-subnet \
    --admin-username azureuser \
    --generate-ssh-keys \
    --custom-data cloud-init.txt
done
8. Add VMs to Backend Pool
bash
for i in 1 2 3
do
  az network nic ip-config address-pool add \
    -g rg-loadbalancer \
    --nic-name vm$i"VMNic" \
    --ip-config-name ipconfig1 \
    --lb-name web-lb \
    --address-pool web-backend
done
🔐 Security
NSG restricts inbound traffic

Only HTTP and SSH allowed

VMs placed in isolated subnet

Load Balancer uses health probes for resilience

📄 Documentation
Additional documentation is available in:
docs/overview.md

🎯 Learning Outcomes
By completing this project, you demonstrate:

Load balancing fundamentals

High‑availability architecture

Azure networking

VM provisioning

NSG configuration

Infrastructure automation

🧩 Next Steps
Enhance this project by adding:

VM Scale Set (VMSS)

Application Gateway (Layer 7)

Azure Bastion

Private endpoints

Monitoring with Azure Monitor
