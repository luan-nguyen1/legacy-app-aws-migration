# 🏗 LegacyApp Migration to AWS

🚀 Migrated a legacy .NET application from on-premise to AWS EC2 using Terraform for automation.

## 📌 Overview

This project demonstrates moving a .NET app to AWS EC2, ensuring scalability and reliability.

- Deployed to AWS using Terraform

- Runs on EC2 with .NET 8

- Uses Amazon Linux

- Secured with AWS Security Groups

## ⚙️ Tech Stack

- AWS EC2 (t3.micro - Free Tier Eligible)

- Terraform (Infrastructure as Code)

- Amazon Linux 2023

- .NET 8.0

## 📂 Architecture

(Local) → (AWS EC2) → (Application) → (HTTP Response)

- Deployed EC2 instance using Terraform
- Configured security groups for SSH & API access
- Installed .NET 8 and hosted the app
- Automated the startup process using systemd

## 🚀 Deployment Steps

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/LegacyApp-Migration-AWS.git
cd LegacyApp-Migration-AWS
```

### 2️⃣ Deploy EC2 & Security Groups
```bash
cd terraform
terraform init
terraform apply -auto-approve
```

### 3️⃣ Connect to EC2 & Start App

```bash
ssh -i my-key.pem ec2-user@$(terraform output -raw public_ip)
cd /home/ec2-user/LegacyApp
systemctl status legacyapp  # Check if the app is running
```

If not running, start it manually:
```bash
sudo systemctl restart legacyapp
```

### 4️⃣ Access the App

Browser: http://$(terraform output -raw public_ip):5185

```bash
curl http://$(terraform output -raw public_ip):5185
```

## ✅ What This Project Proves

- You can migrate on-prem apps to AWS

- You automated infrastructure with Terraform

- You successfully ran a .NET app on EC2

- You secured the instance & configured networking

## 📌 Next Steps

- Add Auto Scaling with an ASG (Auto Scaling Group)

- Move to AWS Lambda & API Gateway for cost savings

- Containerize with Docker + ECS for better scalability
