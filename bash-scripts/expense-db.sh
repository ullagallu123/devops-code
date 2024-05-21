#!/bin/bash

USERID=$(id -u) # It gives user id
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1)
LOG_FILE=/tmp/$TIMESTAMP-$SCRIPT_NAME.log

read -p "Please Enter your root passwd:" mysql_root_passwd
# colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "Script started executing at: $TIMESTAMP"
echo "Log file: $LOG_FILE"

# Check if the script is run as root
if [ $USERID -ne 0 ]; then
    echo -e "${R}Please run this script with sudo privileges${N}"
    exit 1
else
    echo -e "${G}Here we go to installation${N}"
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2.......$R Failed $N"
        exit 1
    else
        echo -e "$2.....$G Success $N"
    fi
}

# Check if MySQL is already installed
if dnf list installed mysql-server &>/dev/null; then
    echo -e "${Y}MySQL server is already installed, skipping installation${N}"
else
    dnf install mysql-server -y &>>$LOG_FILE
    VALIDATE $? "Installing MySQL"
fi

systemctl start mysqld &>>$LOG_FILE
VALIDATE $? "Starting MySQL Service"

systemctl enable mysqld &>>$LOG_FILE
VALIDATE $? "Enabling MySQL Service to start on boot"

# Check if mysql_secure_installation command is available
if command -v mysql_secure_installation &>/dev/null; then
    mysql_secure_installation --set-root-pass ${mysql_root_passwd} &>>$LOG_FILE
    VALIDATE $? "Setting Root Password"
else
    echo -e "${Y}mysql_secure_installation command not found, skipping root password setup${N}"
fi

echo "Script execution completed at: $(date +%F-%H-%M-%S)"
