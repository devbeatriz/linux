#!/usr/bin/env bash

# Need EPEL and CRB for the extra stuff
echo "Enabling EPEL and CRB repos..."
dnf install -y epel-release && crb enable

# My go-to networking and system tools
PACKAGES="nmap-ncat bind-utils net-tools traceroute htop wget mlocate"

# Check for root and web access first
[ "$EUID" -ne 0 ] && echo "Error: Must run as root." && exit 1
ping -c 1 google.com > /dev/null 2>&1 || { echo "Error: No internet connection."; exit 1; }

echo "Installing tools..."
dnf install -y $PACKAGES

# Index files so 'locate' works right away
echo "Updating file database..."
updatedb

echo -e "\n--- Installed packages ---"
dnf list installed $PACKAGES

echo -e "\nDone."