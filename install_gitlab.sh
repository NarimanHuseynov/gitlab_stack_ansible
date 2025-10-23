#!/bin/bash
set -e

echo "🚀 Starting GitLab stack deployment..."

# === 1️⃣ Проверка прав ===
if [[ $EUID -ne 0 ]]; then
  echo "❌ Please run as root (use sudo)"
  exit 1
fi

# === 2️⃣ Установка зависимостей ===
echo "📦 Installing Ansible and required packages..."
apt update -y
apt install -y python3 python3-pip git ansible

# === 3️⃣ Проверка структуры проекта ===
PROJECT_DIR="$(dirname "$0")/ansible_project"
if [ ! -d "$PROJECT_DIR" ]; then
  echo "❌ Folder 'ansible_project' not found at $(pwd)"
  exit 1
fi

cd "$PROJECT_DIR"

if [ ! -f playbooks/site.yml ]; then
  echo "❌ playbooks/site.yml not found in $PROJECT_DIR"
  exit 1
fi

# === 4️⃣ Запуск Ansible playbook ===
echo "🚀 Running Ansible playbook from: $PROJECT_DIR"
ansible-playbook -i hosts.ini playbooks/site.yml

echo "✅ GitLab Stack successfully deployed!"
echo "🌐 Access: http://10.22.255.224"
echo "👤 Login: root / Nh12345678!!"
