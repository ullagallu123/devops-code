#!/bin/bash

USERID=(id -u) # It gives user id
# Check root user or not

if [ $USERID -ne 0]
then
    echo "Please run as this script with sudo privilages"
else
    echo "Here we go to installation"
fi

VALIDATE(){
    if [ $? -ne 0 ]
    then
        echo "Failed"
    else
        echo "Success"
    fi
}

dnf install mysql-server -y

systemctl start mysqld

systemctl enable mysqld

mysql_secure_installation --set-root-pass siva