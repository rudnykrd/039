#!/bin/sh

wget -nc https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-7.3.1-x64.bin
wget -nc https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.48.tar.gz
chmod a+x atlassian-confluence-7.3.1-x64.bin
/home/vagrant/atlassian-confluence-7.3.1-x64.bin -q -varfile response.varfile
tar -xzf mysql-connector-java-5.1.48.tar.gz && cp mysql-connector-java-5.1.48/mysql-connector-java-5.1.48.jar /opt/atlassian/confluence/confluence/WEB-INF/lib
/etc/init.d/confluence restart