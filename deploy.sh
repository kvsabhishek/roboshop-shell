#! /bin/bash

USERID=$(id -u)
N="\e[0m"
R="\e[31m"
G="\e[32m"
Y="\e[33m"

SERVERS=("web" "catalouge" "cart" "user" "shipping" "payments" "ratings" "mongodb" "redis" "mysql" "rabitmq")

VALIDATE(){
    if [ $1 -gt 0 ]
    then
        echo -e "$2 ----------> $R FAILURE$N"
        exit 2
    else
        echo -e "$2 ----------> $G SUCCESS$N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR ::: Dont have enough previlage to run this script$N"
    exit 1
else
    for i in ${SERVERS[@]}
    do
        aws ec2 run-instances --image-id ami-051f7e7f6c2f40dc1 --count 1 --instance-type t2.micro --key-name Devops --security-group-ids sg-0339b8c4272635bfa --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value='${i}'}]">> /tmp/aws.log
    done
fi


