#!/bin/bash

trap "echo -e '\nTerminating...'; exit 1" SIGINT

echo "Welcome to 5 Monkeys Agency!"
echo
echo "We're always looking for skilled developers who share our love for open source and the terminal! :)"
echo
echo "Let's get going! This will be quick. Please enter your details to apply."
echo

get_input() {
  local prompt="$1"
  read -p "$prompt" input
  echo "$input"
}

email=$(get_input "E-mail: ")
github=$(get_input "GitHub profile URL: ")
editor=$(get_input "Favourite editor/IDE: ")
languages=$(get_input "Favourite programming languages (enter your top 3 picks on one line): ")
shell=$(get_input "Favourite shell: ")
db_server=$(get_input "Favourite database server: ")
web_server=$(get_input "Favourite web server: ")
cli_tool=$(get_input "Favourite command-line tool: ")
role=$(get_input "Preferred developer role(s) (i.e. back-end, front-end, full-stack, devops, sysadmin/SRE, etc.): ")
first_code=$(get_input "At what age did you write your first line of code and in which language was it? Answer: ")
total_years=$(get_input "How many years have you been coding in total (including any education or hobbyist coding)? Answer: ")
professional_years=$(get_input "Not including education or hobbyist coding, how many years have you coded professionally (as a part of your paid work)? Answer: ")
country=$(get_input "Country of residence: ")
city=$(get_input "City of residence: ")
source=$(get_input "Found out about the SSH-server join.5monkeys.se via: ")

echo
echo "That's all we need for now. We'll get in touch!"
echo
echo "Make sure to check out our open source projects at https://github.com/5monkeys"
echo
echo "Talk to you soon!"
echo
echo "PS. If you feel that your GitHub profile submitted above does not fully"
echo "communicate your skill set or interests, then consider also sending a short"
echo "e-mail introduction to <jobb+ssh@5monkeys.se>. We don't want to miss great talent"
echo "due to empty GitHub profiles :)"

# Save the collected information to a file
output_file="/tmp/application_$(date +%s).txt"
{
    echo "E-mail: $email"
    echo "GitHub profile URL: $github"
    echo "Favourite editor/IDE: $editor"
    echo "Favourite programming languages: $languages"
    echo "Favourite shell: $shell"
    echo "Favourite database server: $db_server"
    echo "Favourite web server: $web_server"
    echo "Favourite command-line tool: $cli_tool"
    echo "Preferred developer role(s): $role"
    echo "First line of code and language: $first_code"
    echo "Total years coding: $total_years"
    echo "Professional years coding: $professional_years"
    echo "Country of residence: $country"
    echo "City of residence: $city"
    echo "Found out about the SSH server via: $source"
} > "$output_file"

# Optionally, email the results (requires mailutils to be installed)
# mail -s "New Application" jobb+ssh@5monkeys.se < "$output_file"

# Close the connection
exit 0
