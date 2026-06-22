#!/bin/bash

echo "Deploying Public Load Balancer..."

# Create Public IP
az network public-ip create \
  -g rg-loadbalancer \
  -n lb-pip \
  --sku Standard

echo "Public IP created."

# Create Load Balancer
az network lb create \
  -g rg-loadbalancer \
  -n web-lb \
  --sku Standard \
  --public-ip-address lb-pip \
  --frontend-ip-name web-frontend \
  --backend-pool-name web-backend

echo "Load Balancer created."

# Create Health Probe
az network lb probe create \
  -g rg-loadbalancer \
  --lb-name web-lb \
  -n web-probe \
  --protocol tcp \
  --port 80

echo "Health probe created."

# Create LB Rule
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

echo "Load Balancer rule created successfully."
