# Welcome to TheMedina's AWS Efficiency Project!

Join me as we implement tips and tricks on how to streamline AWS infrastructure design, development, and managment using code.

# Updates
**04.05.2018 -** Take a look at the work that my buddy [Keric and I did over here!](https://themedina.github.io/serverless-fun/)

## Goals

I'll be updating this project as much as possible. We'll go over everything from local EC2 bash solutions, to auto scaling with EFS, etc. How do we effectively local EC2 users? How do we manage their keys? What is a Bastion host? Let me walk you through it. Take a look at an example bash script I started including in all my EC2 instances to make local user account creation a breeze.

```markdown
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
```
## Support or Contact

If you have any questions or comments please feel free to contact me at  medina@skillcappedgames.com
