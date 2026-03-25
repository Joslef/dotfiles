#!/usr/bin/env python3
import subprocess, os, time, json

try:
    out = subprocess.check_output(["ip", "route", "get", "8.8.8.8"], stderr=subprocess.DEVNULL).decode()
    iface = out.split()[out.split().index("dev") + 1]
except:
    print(json.dumps({"text": "no net"}))
    exit()

try:
    rx = int(open(f"/sys/class/net/{iface}/statistics/rx_bytes").read())
    tx = int(open(f"/sys/class/net/{iface}/statistics/tx_bytes").read())
except:
    print(json.dumps({"text": "err"}))
    exit()

now = time.time()
state_file = f"/tmp/waybar_netspeed_{iface}"

if os.path.exists(state_file):
    with open(state_file) as f:
        prev_rx, prev_tx, prev_time = map(float, f.read().split())
    elapsed = now - prev_time
    if elapsed > 0:
        rx_speed = (rx - prev_rx) / elapsed / 1048576
        tx_speed = (tx - prev_tx) / elapsed / 1048576
        print(json.dumps({"text": f"{rx_speed:06.3f} MB/s 󰇚  {tx_speed:06.3f} MB/s 󰕒"}))
    else:
        print(json.dumps({"text": "..."}))
else:
    print(json.dumps({"text": "..."}))

with open(state_file, "w") as f:
    f.write(f"{rx} {tx} {now}")
