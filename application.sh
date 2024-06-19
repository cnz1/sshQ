#!/bin/bash

abend() 
{       
    stty sane
    exit
    # Resets stty and then exits script
}

DoAction() {
    stty -echo 
    # Turn off echo
    tput sc
    # Save cursor position
    echo -ne "\033[0K\r"
    # Clear the current line
    echo -e "\033[48;5;57m[$(printf "%05d" $count)]\033[0m Enter your $1: $Keys"
    # Echo currently typed text with elapsed time
    stty echo
    # Turn echo on
    tput rc
    # Return cursor
}

main() {
    trap abend SIGINT # Trap ctrl-c to return terminal to normal
    stty -icanon time 0 min 0 -echo
    # Turn off echo and set read time to nothing
    keypress=''

    echo "Welcome to cnz1 questions!"
    echo
    echo "Let's get going! Please enter your details to apply."

    # Array of prompts
    prompts=("E-mail" "Full Name" "Address")

    for prompt in "${prompts[@]}"; do
        count=0
        clock=0
        Keys=""
        echo -ne "\033[48;5;57m[00000]\033[0m Enter your $prompt: "
        while Keys=$Keys$keypress; do
            sleep 0.05
            read keypress && break
            ((clock = clock + 1))
            if [[ clock -eq 20 ]]; then
                ((count++))
                clock=0
                DoAction "$prompt" $Keys
            fi
        done
        
    done

    stty sane
    echo "Thanks for using this script."
    exit 0
}

main
