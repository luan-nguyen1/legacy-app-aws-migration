# Legacy App Migration to AWS 

Migrated a legacy .NET application from on-premise to AWS EC2 using Terraform for automation.

## Overview 

This project demonstrates moving a .NET app to AWS EC2, ensuring scalability and reliability.

- Deployed to AWS using Terraform

- Runs on EC2 with .NET 8

- Uses Amazon Linux

- Secured with AWS Security Groups

## Tech Stack  

- AWS EC2 (t3.micro - Free Tier Eligible)

- Terraform (Infrastructure as Code)

- Amazon Linux 2023

- .NET 8.0

## Architecture  

(Local) → (AWS EC2) → (Application) → (HTTP Response)

- Deployed EC2 instance using Terraform
- Configured security groups for SSH & API access
- Installed .NET 8 and hosted the app
- Automated the startup process using systemd

## Deployment Steps 

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/LegacyApp-Migration-AWS.git
cd LegacyApp-Migration-AWS
```

### 2. Deploy EC2 & Security Groups
```bash
cd terraform
terraform init
terraform apply -auto-approve
```

### 3. Connect to EC2 & Start App

```bash
ssh -i my-key.pem ec2-user@$(terraform output -raw public_ip)
cd /home/ec2-user/LegacyApp
systemctl status legacyapp  # Check if the app is running
```

If not running, start it manually:
```bash
sudo systemctl restart legacyapp
```

### 4. Access the App

Browser: http://$(terraform output -raw public_ip):5185

```bash
curl http://$(terraform output -raw public_ip):5185
```

## Lessons Learned  
[🔗 Read the technical breakdown on Medium ](https://medium.com/@luanmacek/building-a-serverless-api-with-aws-lambda-api-gateway-dynamodb-22c9bb06ef5b)
