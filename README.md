# Vagrant

---

### Задание 1 - Введение в Vagrant

1. `Установи Vagrant и VirtualBox.`
2. `Создай проект в любой папке`
3. `Настрой Vagrantfile, чтобы использовать базовую ОС Ubuntu.`
4. `Запусти виртуальную машину с помощью команды vagrant up.`

``` ~Решение~
1.
vagrant --version
  Vagrant 2.4.3
2.
mkdir vagrant_start && cd vagrant_start
vagrant init
....
.
└── Vagrantfile
....
3.
nano Vagrantfile
....
  Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
  end
....
4.
vagrant up
....
.
├── ubuntu-bionic-18.04-cloudimg-console.log
└── Vagrantfile
....
```

`Cкриншоты
![vagrant_start](https://github.com/DavyRoy/vagrant/blob/main/vagrant_start/images/Vagrant_start.png)

---

### Задание 2 - Работа с Vagrantfile

1. `Настроить свой Vagrantfile с несколькими параметрами: Используй образ Ubuntu (или любой другой). Настрой приватную сеть (с динамическим IP). Добавь настройку для синхронизации папок между хостом и виртуальной машиной. Выдели не менее 2 ГБ памяти для виртуальной машины.`
2. `Запусти команду vagrant up, чтобы создать виртуальную машину с твоими настройками.`

``` ~Решение~
1.
mkdir vagrant_working && cd vagrant_working
vagrant init
nano Vagrantfile 
....
  Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder "./data", "/vagrant_data"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    end
  end
....
2.
vagrant up
....
```

`Cкриншоты
![vagrant_working](https://github.com/DavyRoy/vagrant/blob/main/vagrant_working/images/vagrant_working.png)

---

### Задание 3 - Основы команд Vagrant

1. `Применить все основные команды для управления виртуальными машинами: Запусти, приостанови, останови и удали виртуальную машину. Проверь состояние машины с помощью команды vagrant status. Подключись к машине с помощью vagrant ssh. Перезагрузи виртуальную машину с помощью команды vagrant reload.`

``` ~Решение~
1.
mkdir vagrant_command && cd vagrant_command
vagrant init
nano Vagrantfile
....
  Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
  end
....
vagrant status
vagrant reload
vagrant destroy
vagrant status
....
```

`Cкриншоты
![vagrant up](https://github.com/DavyRoy/vagrant/blob/main/vagrant_command/images/vagrant%20up.png)
![vagrant status](https://github.com/DavyRoy/vagrant/blob/main/vagrant_command/images/vagrant%20status.png)
![vagrant reload](https://github.com/DavyRoy/vagrant/blob/main/vagrant_command/images/vagrant%20reload.png)
![vagrant destroy](https://github.com/DavyRoy/vagrant/blob/main/vagrant_command/images/vagrant%20destroy.png)

---

### Задание 4 - Сетевые настройки и провайдеры

1. `Настроить свою виртуальную машину с использованием публичного IP`
2. `Добавить настройки провайдера в Vagrantfile: Провайдер Docker.`

``` ~Решение~
1.
mkdir vagrant_network && cd vagrant_network
vagrant init
nano Vagrantfile
....
  Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.network "public_network", bridge: "enp0s3"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024" 
    end
  end
....
vagrant up
2.
nano Vagrantfile
....
  Vagrant.configure("2") do |config|
    config.vm.define "docker_vm" do |d|
      d.vm.provider "docker" do |docker|
        docker.image = "ubuntu"
      end
    end
  end
....
```

`Скриншоты
![vagrant_network](ссылка на скриншот)`
![vagrant_network](https://github.com/DavyRoy/vagrant/blob/main/vagrant_network/images/vagrant_working.png)`

---

### Задание 5 - Provisioning и автоматизация

1. `Написать скрипт для автоматической настройки сервера: Напиши Ansible playbook, который автоматически настроит виртуальную машину. Например, установит веб-сервер Nginx. Используй Vagrant для выполнения скрипта.`

``` ~Решение~
1.
mkdir vagrant_provisioning && cd vagrant_provisioning
vagrant init
nano Vagrantfile
....
  Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "setup.yml"
    end

    config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
  nd
....
nano setuo.sh
....
---
- name: Setup web server
  hosts: all
  become: yes
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
....
vagrant up
```

`Скриншоты
![Скриншот ](ссылка на скриншот)`

---

### Задание 6 - Работы с несколькими виртуальными машинами

1. `Создать несколько VM и настроить их для работы в сети: Используйте Vagrantfile для создания хотя бы двух виртуальных машин, которые смогут взаимодействовать друг с другом. Убедитесь, что они могут пинговать друг друга через приватную сеть. Настройте на одном сервере веб-сервер (например, Nginx или Apache), а на другом — базу данных.`
2. `Управление несколькими виртуальными машинами: Запустите несколько машин одновременно с помощью vagrant up. Остановите и уничтожьте виртуальные машины с использованием команд vagrant halt и vagrant destroy.`

``` ~Решение~
1.
mkdir vagrant_micro && cd vagrant_micro
vagrant init
nano Vagrantfile
....
 Vagrant.configure("2") do |config|
  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/bionic64"
    web.vm.network "private_network", type: "dhcp"
    web.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
    web.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y nginx
    SHELL
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/bionic64"
    db.vm.network "private_network", type: "dhcp"
    db.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
    db.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y mysql-server
    SHELL
  end
end
....
vagrant up
vagrant ssh web
  ip a
  ping
vagrant ssh web
  ip a
  ping
vagrant halt
vagrant destroy
....
```

`Скриншоты
![vagrant_web](https://github.com/DavyRoy/vagrant/blob/main/vagrant_micro/images/vagrant%20web.png)
![vagrant_db](https://github.com/DavyRoy/vagrant/blob/main/vagrant_micro/images/vagrant%20db.png)
![vagrant_halt](https://github.com/DavyRoy/vagrant/blob/main/vagrant_micro/images/vagrant%20halt.png)
![vagrant_destro](https://github.com/DavyRoy/vagrant/blob/main/vagrant_micro/images/vagrant%20destro.png)

---

### Задание 7 - Итоговый проект

1. `Создать 3 виртуальные машины: Web-сервер (Nginx + статическая страница). База данных (PostgreSQL). CI/CD сервер (Jenkins).`
2. `Настроить сеть между машинами (private_network).`
3. `Автоматизировать развертывание с помощью Shell/Ansible.`

``` ~Решение~
1.
mkdir vagrant_end && cd vagrant_end
mkdir scripts && cd scripts
nano setup_web.sh
....
  #!/bin/bash
  apt update -y
  apt install -y nginx
  echo "<h1>Vagrant Web Server</h1>" > /var/www/html/index.html
  systemctl restart nginx
....
nano setup_db.sh
....
  #!/bin/bash
  apt update -y
  apt install -y postgresql postgresql-contrib
  sudo -u postgres psql -c "CREATE DATABASE vagrant_db;"
....
nano setup_ci.sh
....
  #!/bin/bash
  apt update -y && apt upgrade -y
  apt install -y openjdk-11-jdk wget gnupg
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
  echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
  apt update -y
  apt install -y jenkins
  systemctl enable --now jenkins
....
vagrant init
nano Vagrantfile
....
 Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.define "web" do |web|
    web.vm.network "private_network", ip: "192.168.56.10"
    web.vm.provision "shell", path: "scripts/setup_web.sh"
  end

  config.vm.define "db" do |db|
    db.vm.network "private_network", ip: "192.168.56.11"
    db.vm.provision "shell", path: "scripts/setup_db.sh"
  end

  config.vm.define "ci" do |ci|
    ci.vm.network "private_network", ip: "192.168.56.12"
    ci.vm.provision "shell", path: "scripts/setup_ci.sh"
  end
end
....
vagrant up
vagrant ssh web
curl 192.168.56.10
```

`Скриншоты
![vagrant_end](https://github.com/DavyRoy/vagrant/blob/main/vagrant_end/images/vagrant_end.png)

---
