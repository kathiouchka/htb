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
mkdir "$dir_name/gobuster"

# Run nmap scan and save the results to a file
nmap -sC -sV -oN "$dir_name/nmap/results.txt" -p- --min-rate=1000 -v "$target_ip"

# Open the info.txt file with mousepad text editor
mousepad "$dir_name/info.txt" &

# Check if port 80 is open
if grep -q "80/tcp open" "$dir_name/nmap/results.txt"; then
  # Open the URL in Firefox
    firefox http://$target_ip &
    gobuster dir -u http://$target_ip -w /usr/share/wordlists/dirb/common.txt -o "$dir_name/gobuster/output.txt"
else
  echo "Port 80 is not open"
fi