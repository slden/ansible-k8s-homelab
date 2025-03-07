Vagrant.configure("2") do |config|
  # Используем образ Ubuntu 20.04.
  # Пример: "generic/ubuntu2004" – актуальный образ для Ubuntu 20.04.
  config.vm.box = "generic/ubuntu2004"
  config.vm.box_version = "4.3.12" 
  
  # Конфигурация виртуальной машины k8s-master
  config.vm.define "k8s-master" do |master|
    master.vm.hostname = "k8s-master"
    # Настройка сетевого адаптера типа "сетевой мост"
    master.vm.network "public_network", bridge: "wlp1s0"
    master.vm.provider "virtualbox" do |vb|
    vb.name = "k8s-master"
    vb.cpus = 2
    vb.memory = 2048
    end
    # Размер диска будет задан по умолчанию, заданный в box (обычно 10-20 ГБ)
  end
  
  # Конфигурация виртуальной машины k8s-node
  config.vm.define "k8s-node" do |node|
    node.vm.hostname = "k8s-node"
    node.vm.network "public_network", bridge: "wlp1s0"
    node.vm.provider "virtualbox" do |vb|
    vb.name = "k8s-node"
    vb.cpus = 2
    vb.memory = 2048
    end
  end
end