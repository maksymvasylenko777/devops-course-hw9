output "aws_region" {
  description = "AWS region used by this homework."
  value       = data.aws_region.current.region
}

output "packer_ami_id" {
  description = "Latest Packer AMI ID selected by Terraform."
  value       = data.aws_ami.packer_nginx.id
}

output "packer_ami_name" {
  description = "Latest Packer AMI name selected by Terraform."
  value       = data.aws_ami.packer_nginx.name
}

output "instance_id" {
  description = "EC2 instance ID launched from the Packer AMI."
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance."
  value       = aws_instance.web.public_ip
}

output "web_url" {
  description = "URL for opening the nginx page."
  value       = "http://${aws_instance.web.public_ip}"
}

output "ssh_command" {
  description = "SSH command for connecting to the EC2 instance."
  value       = "ssh -i ${var.ssh_private_key_path} ec2-user@${aws_instance.web.public_ip}"
}

output "ansible_inventory_host" {
  description = "Inventory line for running the Ansible playbook against this instance."
  value       = "hw9-web ansible_host=${aws_instance.web.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=${var.ssh_private_key_path}"
}
