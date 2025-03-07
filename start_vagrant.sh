#!/bin/bash

# 1. Запускаем Vagrant
echo "🚀 Запускаем Vagrant..."
vagrant up

# 2. Функция для получения IP-адреса bridged-интерфейса
get_bridge_ip() {
  local vm_name=$1
  # Получаем только IP-адрес интерфейса eth1
  vagrant ssh "$vm_name" -c "ip -o -4 addr show eth1" 2>/dev/null | awk '{print $4}' | cut -d'/' -f1
}

# 3. Получаем IP-адреса для k8s-master и k8s-node
MASTER_BRIDGE_IP=$(get_bridge_ip k8s-master)
NODE_BRIDGE_IP=$(get_bridge_ip k8s-node)

# Проверяем, что IP-адреса найдены
if [[ -z "$MASTER_BRIDGE_IP" || -z "$NODE_BRIDGE_IP" ]]; then
  echo "❌ Ошибка: Не удалось получить IP-адреса bridged-интерфейсов!"
  exit 1
fi

# 4. Записываем IP-адреса в inventory.ini в нужном формате
echo "📥 Обновляем inventory.ini..."
cat <<EOF > inventory.ini
[all]
k8s-master ansible_host=$MASTER_BRIDGE_IP
k8s-node ansible_host=$NODE_BRIDGE_IP

[master]
k8s-master

[worker]
k8s-node
EOF

echo "Файл inventory.ini обновлён:"
cat inventory.ini

echo "🚀 Запускаем Ansible..."
ansible-playbook -i inventory.ini  k8s_lab_setup.yml -k -u vagrant -p vagrant


# echo "Останавливаем машины"
# vagrant halt

# echo "Выключаем NAT-интерфейсы"
# VBoxManage modifyvm "k8s-master" --nic1 none
# VBoxManage modifyvm "k8s-node" --nic1 none

# echo "Запускаем машины"
# VBoxManage startvm "k8s-master" --type headless
# VBoxManage startvm "k8s-node" --type headless


