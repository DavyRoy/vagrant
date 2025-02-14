#!/bin/bash
apt update -y && apt upgrade -y
apt install -y openjdk-11-jdk wget gnupg
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt update -y
apt install -y jenkins
systemctl enable --now jenkins
