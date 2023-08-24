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

if [ $USERID -ne 0 ]
then 
    echo -e "$R ERROR :: Run as sudo user$N"
    exit 1
if