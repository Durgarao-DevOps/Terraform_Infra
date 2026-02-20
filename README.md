📦 EKS Platform Infrastructure (Production-Grade VPC + Terraform Architecture)
📖 Overview

This repository contains the infrastructure code for a production-ready Amazon EKS platform.

The foundation of this platform is a highly available, multi-AZ VPC architecture designed following AWS best practices and real-world enterprise patterns.

The infrastructure is built using Terraform with:

Reusable modules

Domain-separated state structure

Environment isolation

Scalable networking design

Private-first security model

🏗️ Project Architecture
Folder Structure
.
├── modules/
│   ├── networking/
│   │   └── vpc/
│   │       ├── vpc.tf
│   │       ├── subnets.tf
│   │       ├── igw.tf
│   │       ├── nat.tf
│   │       ├── routes.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│
├── envs/
│   └── dev/
│       └── network/
│           └── vpc/
│               ├── main.tf
│               ├── variables.tf
│               ├── terraform.tfvars
│               └── backend.tf
Architecture Philosophy

This project follows a domain-separated Terraform state pattern, where:

Each domain (networking, compute, storage) has its own state

Each environment (dev, stage, prod) is isolated

Modules are reusable across environments

Infrastructure can evolve independently

🌍 VPC Architecture
CIDR Design
VPC CIDR: 10.0.0.0/16

This provides:

65,536 IP addresses

Long-term scalability

Enough capacity for large Kubernetes clusters

Availability Zones

The VPC spans three Availability Zones for high availability:

us-east-1a

us-east-1b

us-east-1c

Each AZ contains identical subnet tiers.

Subnet Architecture
1️⃣ Public Subnets (/20 per AZ)

Purpose:

Load Balancers (ALB/NLB)

NAT Gateways

Characteristics:

Auto-assign public IPs

Route to Internet Gateway

Tagged for Kubernetes ELB integration

2️⃣ Private App Subnets (/19 per AZ)

Purpose:

EKS worker nodes

Kubernetes pods

Application workloads

Characteristics:

No public IPs

Route outbound via NAT

Tagged for internal load balancers

3️⃣ Private Data Subnets (/21 per AZ)

Purpose:

Databases (RDS)

Caching layers

Internal services

Characteristics:

No internet access

Isolated routing

Strict security boundary

🌐 Routing Design
Internet Gateway

Attached to VPC.

Enables public subnets to access the internet.

Public Route Table
0.0.0.0/0 → Internet Gateway

Associated with public subnets.

NAT Gateways (One per AZ)

Each AZ contains a dedicated NAT Gateway:

Prevents cross-AZ traffic costs

Maintains high availability

Allows outbound-only internet for private subnets

Private App Route Tables
0.0.0.0/0 → NAT Gateway (same AZ)

Enables private workloads to:

Pull container images

Access AWS APIs

Download updates

Without exposing inbound access.

Private Data Route Tables

No internet route.

Only internal VPC communication allowed.

This enforces strict isolation for databases.

🔐 Security Model

The architecture follows a private-first, zero-trust approach:

Worker nodes run in private subnets

Databases are fully isolated

Internet access is controlled via NAT

Public exposure only through load balancers

No direct internet access to application or data layers

☸️ EKS Readiness

This VPC is designed specifically to support Amazon EKS:

Proper subnet tagging for load balancer discovery

Multi-AZ worker node placement

Private networking for nodes

Public subnet support for ALB

Scalable IP allocation for pods

🧱 Module Design

The VPC is implemented as a reusable Terraform module.

Key Characteristics:

No hardcoded CIDRs

Subnets created using for_each

Fully parameterized inputs

Environment-agnostic

Reusable across dev/stage/prod

The module follows this principle:

Modules contain logic
Environments contain configuration

🚀 Deployment Order

Initialize backend

Deploy VPC

Deploy compute (EKS)

Deploy add-ons and ingress

Each domain is applied independently.

📈 Scalability Considerations

Large /16 CIDR for growth

Separate subnet tiers

Per-AZ NAT design

Modular architecture for future expansion

Ready for Transit Gateway or hybrid networking

🎯 Design Goals Achieved

✔ High Availability
✔ Private-first security
✔ Enterprise-ready structure
✔ Reusable Terraform modules
✔ Environment isolation
✔ EKS-ready networking
✔ Scalable IP planning

📌 Next Steps

Implement VPC Endpoints

Create IAM roles for EKS

Deploy EKS cluster

Add managed node groups

Install ALB Controller

Configure autoscaling

🧠 Learning Outcome

This project demonstrates:

Real-world VPC design

Terraform module architecture

Multi-AZ networking

Secure subnet segmentation

Production EKS networking foundations


Just tell me how professional you want it to look.# AWS EKS Enterprise Terraform Platform — Project Structure
