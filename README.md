# HW9: Packer AMI And Ansible Web Server

## Goal

Build an AWS AMI with nginx and a custom page using Packer, then express the same web server setup as an Ansible Playbook and an Ansible Role.

## Structure

```text
HW9/
  packer/
    aws-nginx.pkr.hcl
    scripts/install-nginx.sh
  terraform/
    provider.tf
    variables.tf
    main.tf
    outputs.tf
  ansible/
    inventory.ini
    playbook.yml
    roles/web_server/
      defaults/main.yml
      handlers/main.yml
      tasks/main.yml
      templates/index.html.j2
```

## Prerequisites

- AWS CLI installed and configured.
- Packer installed.
- Terraform installed.
- Ansible installed.
- An AWS key pair if you want to launch an EC2 instance from the created AMI later.

Check AWS access:

```bash
aws sts get-caller-identity --profile YOUR_ADMIN_PROFILE
```

Set the profile for the current terminal:

```bash
export AWS_PROFILE=YOUR_ADMIN_PROFILE
```

## Packer

Go to the Packer folder:

```bash
cd HW9/packer
```

Initialize plugins:

```bash
packer init aws-nginx.pkr.hcl
```

Format the file:

```bash
packer fmt aws-nginx.pkr.hcl
```

Validate:

```bash
packer validate aws-nginx.pkr.hcl
```

Build the AMI:

```bash
packer build aws-nginx.pkr.hcl
```

The AMI name starts with:

```text
devops-course-hw9-nginx-
```

## Terraform

Terraform deploys an EC2 instance from the latest AMI created by Packer.

Go to the Terraform folder:

```bash
cd HW9/terraform
```

Initialize Terraform:

```bash
terraform init
```

Format files:

```bash
terraform fmt
```

Validate:

```bash
terraform validate
```

Deploy using your current public IP for SSH access:

```bash
terraform apply -var="allowed_ssh_cidr=$(curl -s https://checkip.amazonaws.com)/32"
```

Open the generated URL:

```bash
terraform output -raw web_url
```

Use the generated Ansible inventory line if you want to run the playbook against the Terraform instance:

```bash
terraform output -raw ansible_inventory_host
```

## Ansible Playbook

Update `ansible/inventory.ini` with your target host.

Run the playbook:

```bash
cd HW9/ansible
ansible-playbook -i inventory.ini playbook.yml
```

Run syntax check:

```bash
ansible-playbook -i inventory.ini playbook.yml --syntax-check
```

## Ansible Role

The playbook uses the local role `web_server`.

Role variables are in:

```text
ansible/roles/web_server/defaults/main.yml
```

Change `web_server_page_title` or `web_server_page_message` to customize the page.

## Cleanup

Packer creates an AMI and snapshot in AWS. Delete the AMI and related snapshot when you no longer need them.

Terraform creates an EC2 instance, security group, and key pair:

```bash
cd HW9/terraform
terraform destroy -var="allowed_ssh_cidr=$(curl -s https://checkip.amazonaws.com)/32"
```
