#!/bin/bash
## ----------------------------------
# Step #1: Define variables
# ----------------------------------

#----------------------------------
# Determine running env
#----------------------------------
set | sort > /tmp/env.cron 
# ----------------------------------
# Step #2: User defined function
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
  exit 0;
}
# do somethingin one()
one(){
        echo "You have chosen to select the Skill Capped Games AWS Environment!";
        set -e;
        export AWS_PROFILE=default;
        pause;
}
 
# do something in two()
two(){
        echo "You have chosen to select the New-Elements AWS Environment!"
        set -e
        export AWS_PROFILE=newElements
        pause
}
# do something in three()
three(){
        echo "three() called"
        pause
} 
# do something in four()
four(){
        echo "four() called"
        pause
} 
# do something in five()
five(){
        echo "five() called"
        pause
} 
# function to display menus
show_menus() {
        clear
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~"      
        echo " SELECT AN AWS ENVIRONMENT"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "1. Skill Capped Games"
        echo "2. New-Elements"
        echo "3. World of Luridia"
        echo "4. RoundTower Tech"
        echo "5. RoundTower-PHH Mortgage"
        echo "6. Exit"
}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
        local choice
        read -p "Enter choice [ 1 - 6] " choice
        case $choice in
                1) one ;;
                2) two ;;
                3) three ;;
                4) four ;;
                5) five ;;
                6) exit 0;;
                *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 
# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
 
        show_menus
        read_options
done