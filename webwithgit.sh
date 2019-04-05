#!/bin/bash
#Checking for apache
service --status-all | grep "Apache" > /dev/null
if [ $? -ne 0 ];
then
	sudo apt -y install apache2
fi
sudo ufw allow "Apache"
systemctl status apache2|grep "Active: active (running)" > /dev/null
if [ $? -ne 0 ];
then

   sudo systemctl start apache2
fi
#Cloning repo from git
git clone http://github.com/RishithaReddyPasnoor/webHosting
#placing the html page
sudo mv ./webHosting/index.html /var/www/html
sudo a2dissite example.com.conf
sudo ls /etc/apache2/sites-enabled |grep 000-default.conf > /dev/null
if [ $? -ne 0 ];
then
  sudo a2ensite 000-default.conf
fi
sudo systemctl restart apache2

