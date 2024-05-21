#!/bin/bash

USERID=$(id -u) # It gives user id
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1)
LOG_FILE=/tmp/$TIMESTAMP-$SCRIPT_NAME.log

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


dnf module disable nodejs:18 -y &>>$LOG_FILE
VALIDATE $? "disable current nodjs module"

dnf module enable nodejs:20 -y &>>$LOG_FILE
VALIDATE $? "enabling nodejs:20"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "installing nodejs 20"

node -v &>>$LOG_FILE
VALIDATE $? "check the version of nodejs"

if id "wages" &>/dev/null; then
    echo -e "${Y}User 'wages' already exists, skipping creation${N}"
else
    useradd wages &>>$LOG_FILE
    VALIDATE $? "Creating user 'wages'"
fi

if ls / | grep /app &>/dev/null; then
     echo -e "${Y}Folder '/app' already exists, skipping creation${N}"
else
    mkdir /app &>>$LOG_FILE
    VALIDATE $? "Creating Folder 'app'"
fi




echo "Script execution completed at: $(date +%F-%H-%M-%S)"