provider "aws" {
  region = "eu-central-1"
}

# 🏗 Launch EC2 Instance
resource "aws_instance" "legacy_app" {
  ami           = "ami-099da3ad959447ffa"  # Amazon Linux (Free Tier)
  instance_type = "t3.micro"               # Free-tier eligible
  key_name      = "my-key"
  vpc_security_group_ids = [aws_security_group.legacy_sg.id]

  # 🛠 Automatically Install & Start .NET App
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y dotnet-sdk-8.0

    # Move to project folder
    cd /home/ec2-user/LegacyApp

    # Run the app on startup using systemd
    cat <<EOF2 | sudo tee /etc/systemd/system/legacyapp.service
    [Unit]
    Description=Legacy .NET App
    After=network.target

    [Service]
    ExecStart=/usr/bin/dotnet run --urls "http://0.0.0.0:5185"
    WorkingDirectory=/home/ec2-user/LegacyApp
    Restart=always
    User=ec2-user

    [Install]
    WantedBy=multi-user.target
    EOF2

    # Enable & Start Service
    sudo systemctl daemon-reload
    sudo systemctl enable legacyapp
    sudo systemctl start legacyapp
  EOF

  tags = {
    Name = "LegacyApp"
  }
}

# 🔐 Security Group for EC2 (Fully Redeployable)
resource "aws_security_group" "legacy_sg" {
  name        = "legacy_sg"
  description = "Allow inbound traffic for SSH & App"

  # ✅ Allow SSH from anywhere (but restrict later using dynamic rules)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ✅ Allow app traffic (port 5185) for public access
  ingress {
    from_port   = 5185
    to_port     = 5185
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ✅ Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 📡 Get Public IP of EC2 (For Automation)
output "public_ip" {
  value = aws_instance.legacy_app.public_ip
}
