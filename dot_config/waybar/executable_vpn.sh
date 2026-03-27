#!/bin/bash
if ip link show tun0 &>/dev/null; then
  IP=$(curl -s --max-time 3 ifconfig.me)
  echo "{\"text\": \"󰌾\", \"tooltip\": \"VPN connected\\nIP: ${IP}\", \"class\": \"connected\"}"
else
  IP=$(curl -s --max-time 3 ifconfig.me)
  echo "{\"text\": \"󱗒\", \"tooltip\": \"VPN disconnected\\nIP: ${IP}\", \"class\": \"disconnected\"}"
fi
