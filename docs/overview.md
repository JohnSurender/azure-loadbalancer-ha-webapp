📄 Project Documentation — Azure Load Balancer High‑Availability Web App
1. Overview
This project implements a high‑availability web application architecture using an Azure Public Load Balancer distributing traffic across three virtual machines. It demonstrates real‑world Azure networking, compute provisioning, and load balancing concepts.

2. Architecture Summary
The solution includes:

Public Load Balancer (Standard SKU)

Frontend IP + Backend Pool

Health Probe (TCP 80)

Load Balancing Rule (HTTP 80 → 80)

Three Ubuntu Web Servers

Virtual Network + Web Subnet

Network Security Group with HTTP + SSH rules

This design supports:

High availability

Horizontal scaling

Fault tolerance

Even traffic distribution

The full diagram is available in:
architecture/lb-diagram.mmd

3. Traffic Flow
Client sends HTTP request to the Load Balancer Public IP.

Load Balancer forwards traffic to one of the healthy VMs.

Health probe checks each VM on port 80.

If a VM becomes unhealthy, it is removed from rotation.

NSG ensures only HTTP and SSH traffic is allowed.

4. Security Considerations
NSG restricts inbound traffic to HTTP (80) and SSH (22).

Standard Load Balancer requires NSG rules for inbound traffic.

VMs are isolated inside a dedicated subnet.

SSH keys are used instead of passwords.

Health probe ensures only healthy VMs receive traffic.

5. Cost Estimation (Approx.)
Component	Quantity	Estimated Monthly Cost
Public IP (Standard)	1	~£2–£3
Load Balancer (Standard)	1	~£15–£20
VMs (B1s)	3	~£10–£12 each
Disks	3	~£3–£4 each
VNet + Subnet	1	Free


Estimated total: ~£55–£65 per month
(Varies by region and VM size)

6. Troubleshooting
Issue: Load Balancer not distributing traffic
Ensure VMs are added to the backend pool.

Confirm health probe is passing.

Verify NSG allows port 80.

Issue: VM not reachable via SSH
Check NSG rule for port 22.

Ensure VM has a public IP (if connecting directly).

Use az vm list-ip-addresses to confirm IP.

Issue: Web app not loading
Confirm cloud‑init installed the web server.

Check VM status:
az vm get-instance-view

Verify port 80 is open on the VM.

7. Future Enhancements
Replace VMs with VM Scale Set (VMSS)

Add Application Gateway for Layer 7 routing

Add Azure Bastion for secure SSH access

Add Private Link for internal‑only access

Add Azure Monitor for metrics and alerts
