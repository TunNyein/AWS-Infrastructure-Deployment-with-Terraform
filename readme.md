# AWS Infrastructure Deployment with Terraform

## 📜 Overview
This Terraform project automates the following resources


- VPCs (the two vpc )
- Public & Private Subnets 
- Route Tables & Associations
- Internet Gateways
- EC2 Instances
- SSH Key Pairs



## ⚙️ Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) ≥ v1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with IAM credentials including permissions


## 🛠️ Deployment
```bash
# Clone repository
git clone https://github.com/your-username/your-repo.git
cd your-repo

# Initialize Terraform
terraform init

# Preview infrastructure changes
terraform plan

# Apply configuration
terraform apply -auto-approve


# After deployment:

Retrieve SSH keys:

```bash
ls ssh-private-keys/
Connect to EC2 instance:

```bash
ssh -i ssh-private-keys/sg_private_key.pem ec2-user@<public-ip>

🧹 Cleanup
To destroy all resources:


terraform destroy -auto-approve
Important: Verify Internet Gateway deletion in AWS Console after destruction

🐛 Troubleshooting
SSH Connection Issues
Verify security group allows inbound TCP/22

Check instance public IP address

Ensure using correct PEM key:

``` bash
chmod 400 ssh-private-keys/sg_private_key.pem
General Tips