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
fi

for i in "${SERVERS[@]}"
do
    echo "$i"
done