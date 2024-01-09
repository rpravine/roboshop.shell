#!/bin/bash

ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 ne 0]
      then
         echo "error : $2 ... is failed"
         exit 1
       else
          echo "$2 ... is success
    fi      "  
}

if [ $ID -ne 0 ]
   then 
      echo "error : run this script with root user" 
      exit 1
   else
       echo "you are root user"   
fi

cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOGFILE

VALIDATE$? "copying mongo.repo"

dnf install mongodb-org -y 

VALIDATE$? "installing mongo db"

systemctl enable mongod

VALIDATE$? "enabling mongo db"

systemctl start mongod

VALIDATE$? "starting mongo db"

sed -i 's/127.0.0.1/0.0.0.0/g'  /etc/mongod.conf &>> $LOGFILE

VALIDATE $? "Remote access to MongoDB"

systemctl restart mongod &>> $LOGFILE

VALIDATE $? "Restarting MongoD

