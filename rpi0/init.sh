#!/bin/bash

echo -e "### Time to remove unused kernels: ###"
sudo apt remove linux-*v7 linux-*v7l linux-*v8 -y
echo -e "### Kernels were removed. ###\n"

echo -e "### Time to upgrade: ###"
sudo apt update
sudo apt full-upgrade -y
echo -e "### System was upgraded. ###\n"

echo -e "### Time to install basic tools (needrestart): ###"
sudo apt install needrestart -y
echo -e "### Basic tools were installed. ###\n"

echo -e "### Time to fix that nasty warning we get when updating repositories: ###"
echo -e "### Exporting key stored in trusted.gpg and storing it the right way… ###"
sudo apt-key export 90FDDD2E | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/raspberrypi-debian-armhf.gpg
echo -e "### Backing up files… ###"
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo mv /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak
echo -e "### Files were backed up. ###\n"
echo -e "### Upgrading .list files… ###\n"
sudo cp files/sources.list /etc/apt/
sudo cp files/raspi.list /etc/apt/sources.list.d/
echo -e "### .list files were upgraded. ###\n"

echo -e "### Should you reboot? ###"
sudo needrestart
echo -e "### Would you like to reboot now? TODO ###"
