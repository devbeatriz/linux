#!/usr/bin/env bash
[ "$EUID" -ne 0 ] && echo "Run as root." && exit 1

. /etc/os-release || exit 1
echo "OS: $ID"

case "$ID" in
  rhel|rocky|almalinux|ol|centos)
    dnf install -y epel-release
    crb enable
    dnf install -y nmap-ncat bind-utils net-tools traceroute mtr tcpdump htop wget mlocate iputils
    ;;
  ubuntu|debian)
    apt update
    apt install -y ncat dnsutils net-tools traceroute mtr-tiny tcpdump htop wget plocate iputils-ping
    ;;
  *)
    echo "Unsupported distro: $ID"
    exit 1
    ;;
esac

updatedb 2>/dev/null

echo "Done."
