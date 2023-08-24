#! /bin/bash

DATE=$(date +%F)
LOGDIR=/tmp
SCRIPT_NAME=$0
LOGFILE=$LOGDIR/$SCRIPT_NAME-$DATE.log

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2---------> $R FAILURE $N"
        exit 1
    else
        echo -e "$2---------> $G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then 
    echo -e "$R ERROR :: Run as sudo user$N"
    exit 1
fi

yum install nginx -y
VALIDATE $? "Installing nginx"

systemctl enable nginx
VALIDATE $? "Enabling nginx service"

systemctl start nginx
VALIDATE $? "Sarting nginx service"

rm -rf /usr/share/nginx/html/*
VALIDATE $? "Deleting pre defined files from nginx directory"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip
VALIDATE $? "Downloading roboshop files"

cd /usr/share/nginx/html
VALIDATE $? "Changing to nginx directory"

unzip /tmp/web.zip
VALIDATE $? "Unzipping downloaded roboshop files"

cp ./roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf 
VALIDATE $? "Configuring nginx"

systemctl restart nginx 
VALIDATE $? "Restarting nginx service"