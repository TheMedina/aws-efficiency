#!/bin/bash

# EC2-USERADD
#
# Created by: Christopher L. Medina
# Last modified: 3.14.2018
# This script creates a specified user and corresponding .ssh
# directory. Additionally, it will configure the permissions
# for each accordingly.

# Howto
# ec2-useradd [username] [group]

## Positional Paramater Variables
#  This is so the function can read positional paramaters accurately
USER=$1
GROUP=$2
## This function is the bulk of the non account creation / permission settings
dir_routine () {
    usermod -a -G $GROUP $USER
    chown -R $USER:$USER /home/$USER/.ssh
    chmod 600 /home/$USER/.ssh
    touch /home/$USER/.ssh/authorized_keys
    chown $USER:$USER /home/$USER/.ssh/authorized_keys
    chmod 400 /home/$USER/.ssh/authorized_keys
}
if grep -iw "$1" /etc/passwd > /dev/null;then
   echo "FAILED: User account already exist in /etc/passwd!"
   exit 1
else
   echo "CREATING user account for $1"
   useradd "$1"
   mkdir /home/"$1"/.ssh
 if grep -iw "$2" /etc/group > /dev/null;then
    dir_routine
 else
    echo "WARNING: Group did not exist...CREATING group $2 !"
    groupadd "$2"
    dir_routine
 fi
 if [ $? -eq 0 ];then
    echo "SUCCESS: Created user account $1"
    exit 0
 else
    echo "FAILED: Unexpected error"
    exit 2
 fi
fi
