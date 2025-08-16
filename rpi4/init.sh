#!/bin/bash

sudo apt update
sudo apt remove linux-*2712 -y
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt autoclean

