#!/usr/bin/env bash

# Root + internet
[ "$EUID" -ne 0 ] && echo "Run as root." && exit 1
ping -c1 google.com &>/dev/null || { echo "No internet."; exit 1; }

# OS detection
. /etc/os-release || exit 1
echo "OS: $ID"

case "$ID" in
  rhel|rocky|almalinux|ol|centos)
    dnf install -y epel-release
    crb enable
    PM="dnf install -y"
    PKG_LIST="nmap-ncat bind-utils net-tools traceroute htop wget mlocate"
    LIST_CMD="dnf list installed"
    ;;
  ubuntu|debian)
    apt update
    PM="apt install -y"
    PKG_LIST="ncat dnsutils net-tools traceroute htop wget plocate"
    LIST_CMD="dpkg -l"
    ;;
  *)
    echo "Unsupported distro: $ID"
    exit 1
    ;;
esac

$PM $PKG_LIST
updatedb
$LIST_CMD $PKG_LIST

echo "Done."