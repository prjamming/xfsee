#!/bin/bash

# Create a new user for the VNC session
useradd -m user
echo 'user:user' | chpasswd

# Set up VNC password
mkdir -p /home/user/.vnc
echo "user" | vncpasswd -f > /home/user/.vnc/passwd
chmod 600 /home/user/.vnc/passwd
chown -R user:user /home/user/.vnc

# Start VNC server as user
su - user -c "vncserver :1 -geometry 1280x800 -depth 24"

# Start noVNC
/opt/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080 &
