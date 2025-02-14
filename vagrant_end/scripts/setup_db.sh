#!/bin/bash
apt update -y
apt install -y postgresql postgresql-contrib
sudo -u postgres psql -c "CREATE DATABASE vagrant_db;"
