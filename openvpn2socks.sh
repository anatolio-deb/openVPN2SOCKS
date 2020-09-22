#!/bin/sh
###########################################
# Route all traffic from openVPN to SOCKS #
###########################################

# Install dependencies
apt install redsocks
# Replace default redsocks config
cp ./redsocks.conf /etc/redsocks.conf
# Apply iptables rules (read more at https://github.com/darkk/redsocks)
iptables -t nat -N REDSOCKS
iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A PREROUTING --in-interface tun0 -p tcp -j REDSOCKS
# Restart redsocks with new config
systemctl restart redsocks

