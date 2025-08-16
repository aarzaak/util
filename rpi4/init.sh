#!/bin/bash

sudo apt update
sudo apt remove linux-*v6 linux-v7* linux-*2712 -y
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt autoclean

