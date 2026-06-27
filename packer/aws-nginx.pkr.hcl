packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "project_name" {
  type    = string
  default = "devops-course-hw9"
}

source "amazon-ebs" "nginx" {
  region        = var.aws_region
  instance_type = var.instance_type
  ssh_username  = "ec2-user"
  ami_name      = "${var.project_name}-nginx-${formatdate("YYYYMMDD-hhmmss", timestamp())}"

  source_ami_filter {
    filters = {
      name                = "al2023-ami-*-x86_64"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["amazon"]
    most_recent = true
  }

  tags = {
    Name      = "${var.project_name}-nginx"
    Project   = var.project_name
    ManagedBy = "Packer"
  }
}

build {
  name = "amazon-linux-nginx"

  sources = [
    "source.amazon-ebs.nginx"
  ]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E bash '{{ .Path }}'"
    script          = "scripts/install-nginx.sh"
  }
}
