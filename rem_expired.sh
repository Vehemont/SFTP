#!/bin/bash

# Removes expired accounts and their home directories the 1st of every month.

DATE=`date "+%Y%m%d"`
LOGDIR='/home/someuser/filename.log' # Logs any deletions
IFS=':'

# Iterate through /etc/passwd for all users
while read -r user pass uid gid desc home shell; do
  # Find user with a group ID greater than 999
  if [ $gid == '1001' -a $uid -gt 999 ] 
  then
    # Gets expiration date of account
    expiration=$(chage -l $user | grep "Account expire")

    # Format the month from the chage -l output
    month=$(echo $expiration | cut -d " " -f 4)
    month=$(date -d "${month} 1" +%m)

    # Format the dat from the chage -l output
    day=$(echo $expiration | cut -d " " -f 5)
    day=$(echo ${day//,})

    # Format the year from the chage -l output
    year=$(echo $expiration | cut -d " " -f 6)

    # Get todays date
    today=$(date +"%Y-%m-%d")
    today=$(date -d $today +%s)

    # Turn the expire date into a date object to compare later
    expire_date=$(date -d "${year}${month}${day}+1 month" +%Y-%m-%d)
    echo 'date -d "${year}${month}${day}+1 month" +%Y-%m-%d'
    echo "$expire_date"
    expire_date=$(date -d $expire_date +%s)
    echo 'date -d $expire_date +%s'
    echo "$expire_date"

    # If the expiration date has passed, delete the user quietly.
    if [ $today -ge $expire_date ]
    then
      /sbin/deluser --remove-home --quiet $user
      echo "$DATE - Deleted user: $user" >> $LOGDIR
    fi
  fi
done </etc/passwd
