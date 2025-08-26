#!/bin/bash

set -e  # If any command fails, the script will stop

TERRAFORM_DIR="terraform"

echo "Navigate to the directory $TERRAFORM_DIR..."
cd "$TERRAFORM_DIR"

echo "Run Terraform..."
terraform init
terraform apply -auto-approve

echo "Getting  external IP from Terraform output..."
IP=$(terraform output -raw vm_ip)
echo "External IP: $IP"

cd ..

echo "Create inventory.ini for Ansible..."
cat > inventory.ini <<EOF
[devops]
$IP ansible_user=devops ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF

echo "Waiting when VM is started (30 second)..."
sleep 30

echo "Starting Ansible Playbook..."
ansible-playbook -i inventory.ini ansible/playbook.yml --extra-vars "host_ip=$IP"

echo "Done! Server $IP is configured and ready for deployment"
