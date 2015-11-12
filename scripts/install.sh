#!/usr/bin/env bash
# largely borrowed from https://github.com/AlexDisler/mysql-vagrant/blob/master/install.sh


sudo apt-get update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y vim curl python-software-properties
sudo apt-get update
sudo apt-get -y install mysql-server
sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -u root -proot -e "create database test"
mysql -u root -proot test < /sql/setup_db.sql
sudo /etc/init.d/mysql restart
