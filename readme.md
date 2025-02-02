AWS Infrastructure Deployment with Terraform

Overview

This Terraform project automates the deployment of AWS infrastructure, including VPCs, subnets, route tables, internet gateways, SSH key pairs, and EC2 instances.

Features

VPCs: Creates two VPCs (sg_vpc1 for Production and tk_vpc1 for Development).

Subnets: Defines public and private subnets for each VPC.

Route Tables: Manages routing for public and private networks.

Internet Gateway: Provides internet access to public subnets.

SSH Key Pairs: Generates SSH keys for secure EC2 instance access.

EC2 Instances: Launches instances in the public subnets with assigned key pairs.

Prerequisites

Ensure you have the following installed:

Terraform

AWS CLI configured with appropriate credentials

Deployment Instructions

Clone the repository:

git clone <your-repository-url>
cd <repository-folder>

Initialize Terraform:

terraform init

Review the execution plan:

terraform plan

Apply the configuration:

terraform apply -auto-approve

Retrieve the generated SSH private keys:

ls ssh-private-keys/

Use the appropriate .pem file to access your EC2 instance.

Connect to an EC2 instance:

ssh -i ssh-private-keys/sg_private_key.pem ec2-user@<instance-public-ip>

Resources Created

VPCs and Subnets

sg_vpc1 - Production VPC (10.10.0.0/16)

tk_vpc1 - Development VPC (10.20.0.0/16)

Public and private subnets in ap-southeast-1a and ap-southeast-1b

Networking

Internet gateways for public network access

Route tables and associations for public and private subnets

Routing to internet gateways for external connectivity

Compute

EC2 instances in public subnets

SSH key pairs for secure login

Troubleshooting

Public IP not assigned to EC2 instances:

Ensure associate_public_ip_address = true in aws_instance.

Check if an internet gateway is attached and a route exists.

Permission denied (publickey) when SSHing into EC2:

Ensure the private key has correct permissions:

chmod 400 ssh-private-keys/sg_private_key.pem

Ensure you are using the correct user (ec2-user for Amazon Linux, ubuntu for Ubuntu, etc.).

Terraform errors related to resource dependencies:

Run terraform destroy and then terraform apply to reapply resources cleanly.

Cleanup

To destroy all resources:

terraform destroy -auto-approve

Future Enhancements

Implement an Elastic Load Balancer (ELB) for high availability.

Add IAM roles and security groups for better access control.

Enable logging and monitoring using AWS CloudWatch.

Author

Aung Paing

License

