#!/bin/sh

mysql_root_pass=123456

yum -y localinstall https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
yum -y install mysql-community-server

systemctl enable mysqld
systemctl start mysqld

mysql_root_pass_temp=$(grep 'A temporary password' /var/log/mysqld.log | awk 'END {print $NF}')

## Adjusting the password validation plugin (when your password does not satisfy password policy requirements)
mysql -u root -p$mysql_root_pass_temp --connect-expired-password -e "SET GLOBAL validate_password_policy = 0; SET GLOBAL validate_password_length = 6; SET GLOBAL validate_password_mixed_case_count = 0; SET GLOBAL validate_password_number_count = 0; SET GLOBAL validate_password_special_char_count = 0;"

mysql -u root -p$mysql_root_pass_temp --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$mysql_root_pass'; FLUSH PRIVILEGES;"
mysql -u root -p$mysql_root_pass -e "CREATE DATABASE IF NOT EXISTS CONFLUENCE DEFAULT CHARACTER SET utf8 COLLATE utf8_bin"
mysql -u root -p$mysql_root_pass -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$mysql_root_pass'"

echo 'transaction-isolation=READ-COMMITTED' >> /etc/my.cnf
systemctl restart mysqld