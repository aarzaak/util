#!/bin/bash

echo "Time to remove unused kernels:"
sudo apt remove linux-*v7 linux-*v7l linux-*v8 -y
echo "Kernels were removed."

echo "Time to upgrade:"
sudo apt update
sudo apt full-upgrade -y
echo "System was upgraded."

echo "Time to install basic tools (git and need-restart):"
sudo apt install git need-restart -y
echo "Basic tools were installed."

echo "Time to fix that nasty warning we get when updating repositories:"
echo "Exporting key stored in trusted.gpg and storing it the right way…"
sudo apt-key export 90FDDD2E | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/raspberrypi-debian-armhf.gpg
echo "Backing up files…"
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo mv /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak
echo "Files were backed up."
echo "Upgrading .list files…"
sudo cp files/sources.list /etc/apt/
sudo cp files/raspi.list /etc/apt/sources.list.d/
echo ".list files were upgraded."

echo "Should you reboot?"
sudo need-restart
echo "Would you like to reboot now? TODO"

