#!/bin/bash

echo "Deploying 3 Web Server VMs..."

# Loop to create VM1, VM2, VM3
for i in 1 2 3
do
  echo "Deploying VM$i..."

  az vm create \
    -g rg-loadbalancer \
    -n vm$i \
    --image UbuntuLTS \
    --vnet-name vnet-web \
    --subnet web-subnet \
    --admin-username azureuser \
    --generate-ssh-keys \
    --custom-data cloud-init.txt

  echo "VM$i deployed."
done

echo "All VMs deployed successfully."
