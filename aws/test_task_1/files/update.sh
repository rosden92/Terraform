#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo systemctl enable nginx
sudo apt-get install htop -y
sudo apt-get install vim -y