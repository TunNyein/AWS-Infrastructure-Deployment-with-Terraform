# AWS Infrastructure Deployment with Terraform

## 📜 Overview
This Terraform project automates the following resources


- VPCs 
- Public & Private Subnets 
- Route Tables & Associations
- Internet Gateways
- EC2 Instances
- SSH Key Pairs



## ⚙️ Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) ≥ v1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with IAM credentials including permissions


## 🛠️ Deployment

### Clone repository
```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

### Initialize Terraform
```bash
terraform init
```

### Preview infrastructure changes
```bash
terraform plan
```

### Apply configuration
```bash
terraform apply -auto-approve
```


### After deployment:

### Retrieve SSH keys:

```bash
ls ssh-private-keys/
```

Connect to EC2 instance:

```bash
ssh -i ssh-private-keys/sg_private_key.pem ec2-user@<public-ip>
```

## 🧹 Cleanup
To destroy all resources:

```bash
terraform destroy -auto-approve
```

## 🐛 Troubleshooting

### SSH Connection Issues

- Verify security group allows inbound TCP/22


# Important: Verify Internet Gateway deletion in AWS Console after destruction




Thanks for your visit