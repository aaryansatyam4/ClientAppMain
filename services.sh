#!/bin/bash
echo 180.149.57.100 backend-auth.staging.nic.in >> /etc/hosts &&
sh /usr/local/tomcat/bin/startup.sh &&
tail -f /usr/local/tomcat/logs/catalina.out
