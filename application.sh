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
    
    echo " .----------------.  .-----------------. .----------------.  .----------------. "
    echo "| .--------------. || .--------------. || .--------------. || .--------------. |"
    echo "| |     ______   | || | ____  _____  | || |   ________   | || |     __       | |"
    echo "| |   .' ___  |  | || ||_   \|_   _| | || |  |  __   _|  | || |    /  |      | |"
    echo "| |  / .'   \_|  | || |  |   \ | |   | || |  |_/  / /    | || |    \`| |      | |"
    echo "| |  | |         | || |  | |\ \| |   | || |     .'.' _   | || |     | |      | |"
    echo "| |  \ \`.___.'\  | || | _| |_\   |_  | || |   _/ /__/ |  | || |    _| |_     | |"
    echo "| |   \`._____.'  | || ||_____|\____| | || |  |________|  | || |   |_____|    | |"
    echo "| |              | || |              | || |              | || |              | |"
    echo "| '--------------' || '--------------' || '--------------' || '--------------' |"
    echo " '----------------'  '----------------'  '----------------'  '----------------' "
    echo
    echo "Welcome to cnz1 questions!"
    echo
    echo "Let's get going!"

    # Array of prompts
    prompts=(
        "E-mail"
        "Full Name"
        "Address"
        "GitHub profile URL"
        "Favourite editor/IDE"
        "Favourite programming languages"
        "Favourite shell"
        "Favourite database server"
        "Favourite web server"
        "Favourite command-line tool"
        "Preferred developer role(s)"
        "First line of code and language"
        "Total years coding"
        "Professional years coding"
        "Country of residence"
        "City of residence"
        "Found out about the SSH server via"
    )

    # Create or clear the responses file in /tmp
    responses_file="/tmp/responses.txt"
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "Responses recorded at $timestamp:" >> "$responses_file"

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
        echo "[$(printf "%05d" $count)] $prompt: $Keys" >> "$responses_file"
    done
    echo >> "$responses_file"

    stty sane
    echo "Thanks for using this script. Your responses have been saved to $responses_file."
    exit 0
}

main
