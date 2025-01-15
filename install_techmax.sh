#!/bin/bash
sudo su
yum update -y
yum install -y httpd
cd /var/www/html
wget https://github.com/pinnintipavan9989/Pavan_Portfolio/tree/main/archives/refs/heads/portolio-main.zip
unzip portolio-main.zip
cp -r techmax-main/* /var/www/html/
rm -rf portolio-main portolio-main.zip
systemctl enable httpd 
systemctl start httpd