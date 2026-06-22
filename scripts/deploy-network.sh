#!/bin/bash

echo "Deploying Virtual Network, Subnet, and NSG..."

# Create VNet + Subnet
az network vnet create \
  -g rg-loadbalancer \
  -n vnet-web \
  --address-prefix 10.0.0.0/16 \
  --subnet-name web-subnet \
  --subnet-prefix 10.0.1.0/24

echo "VNet and Subnet created."

# Create NSG
az network nsg create \
  -g rg-loadbalancer \
  -n web-nsg

# Allow HTTP
az network nsg rule create \
  -g rg-loadbalancer \
  --nsg-name web-nsg \
  -n allow-http \
  --priority 100 \
  --protocol Tcp \
  --destination-port-ranges 80 \
  --access Allow

# Allow SSH
az network nsg rule create \
  -g rg-loadbalancer \
  --nsg-name web-nsg \
  -n allow-ssh \
  --priority 110 \
  --protocol Tcp \
  --destination-port-ranges 22 \
  --access Allow

echo "NSG and rules created."

# Associate NSG with Subnet
az network vnet subnet update \
  -g rg-loadbalancer \
  --vnet-name vnet-web \
  -n web-subnet \
  --network-security-group web-nsg

echo "Network deployment completed successfully."
