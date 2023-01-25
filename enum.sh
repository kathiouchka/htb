#!/bin/bash

# Prompt user for directory name
read -p "Enter a name for the directory: " dir_name

# Create the directory
mkdir "$dir_name"

# Prompt user for target IP
read -p "Enter the target IP address: " target_ip

# Copy the IP address to a file named info.txt
echo "IP :$target_ip" > "$dir_name/info.txt"

# Ping the target IP 4 times
ping -c 4 "$target_ip"

# Create the "nmap" and "tests" directorys
mkdir "$dir_name/nmap"
mkdir "$dir_name/tests"

# Run nmap scan and save the results to a file
nmap -sC -sV -oN "$dir_name/nmap/results.txt" -p- --min-rate=1000 -v "$target_ip"

# Open the info.txt file with mousepad text editor
mousepad "$dir_name/info.txt" &

# Change directory to tests
cd "$dir_name/tests"
