
sysctl -p

# ---------
# Set VPN
# ---------
#OVPN=vpns0
#iptables -t nat -A POSTROUTING  -o eth0 -j MASQUERADE
#iptables -A FORWARD  -j ACCEPT

iptables -F
# Allow incoming SSH
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -s 0.0.0.0/0 -j ACCEPT


# Allow DNS outbound
iptables -A OUTPUT -p udp --dport 53 -m state --state NEW -j ACCEPT

# Allow vpn
#iptables -t nat -A POSTROUTING -s 192.168.2.0/24 -o eth0 -j MASQUERADE

iptables -A INPUT -p tcp --dport 80 -m state --state NEW -s 0.0.0.0/0 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m state --state NEW -s 0.0.0.0/0 -j ACCEPT
#
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE


ocserv -c /etc/ocserv/ocserv.conf  -d 10 2>&1 | tee /www/logs/vpn.log
