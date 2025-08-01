#!/bin/bash

set -e  # если любая команда падает — скрипт остановится

TERRAFORM_DIR="terraform"

echo "Переходим в директорию $TERRAFORM_DIR..."
cd "$TERRAFORM_DIR"

echo "Запускаем Terraform..."
terraform init
terraform apply -auto-approve

echo "Получаем внешний IP из Terraform output..."
IP=$(terraform output -raw vm_ip)
echo "Внешний IP: $IP"

cd ..

echo "Создаём inventory.ini для Ansible..."
cat > inventory.ini <<EOF
[devops]
$IP ansible_user=devops ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF

echo "Ожидание запуска VM (30 секунд)..."
sleep 30

echo "Запускаем Ansible Playbook..."
ansible-playbook -i inventory.ini ansible/playbook.yml --extra-vars "host_ip=$IP"

echo "Готово! Сервер $IP настроен и готов к деплою"
