#!/bin/bash
aerospace list-windows --focused | grep -q "AI Chat" && \
    aerospace layout floating && \
    aerospace move-node-to-monitor 'LG HDR 4K'
