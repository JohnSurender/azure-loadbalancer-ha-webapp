#!/bin/bash

echo "Creating Resource Group for Load Balancer Project..."

az group create -n rg-loadbalancer -l uksouth

echo "Resource Group created successfully."
