variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "devops-course-hw9"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,38}[a-z0-9]$", var.project_name))
    error_message = "Use 3-40 lowercase letters, numbers, and hyphens. Start and end with a letter or number."
  }
}

variable "ami_name_prefix" {
  type    = string
  default = "devops-course-hw9-nginx-"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]*$", var.ami_name_prefix))
    error_message = "Use lowercase letters, numbers, and hyphens."
  }
}

variable "instance_type" {
  type    = string
  default = "t3.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "Use t2.micro or t3.micro for this homework."
  }
}

variable "allowed_http_cidr" {
  type    = string
  default = "0.0.0.0/0"

  validation {
    condition     = can(cidrnetmask(var.allowed_http_cidr))
    error_message = "Use valid CIDR notation."
  }
}

variable "allowed_ssh_cidr" {
  type = string

  validation {
    condition     = can(cidrnetmask(var.allowed_ssh_cidr))
    error_message = "Use valid CIDR notation."
  }
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "ssh_private_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519"
}
