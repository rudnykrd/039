yum update
yum install -y httpd
systemctl start httpd
systemctl enable httpd

#systemctl start firewalld
#systemctl enable firewalld
#firewall-cmd --permanent --add-port=80/tcp
#systemctl reload firewalld