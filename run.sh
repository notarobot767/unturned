#!/bin/bash

#This script was intended as a draft to point server admins in the right direction
#Edit it to fit your needs for automation
#Refer to the official documentation and learn the docker compose CLI

#purpose
#start the server and attach screen

cd "${0%/*}"
#ensure working directory is the same as the script
#useful if calling script from another location, like a cron job
#https://stackoverflow.com/questions/6393551/what-is-the-meaning-of-0-in-a-bash-script

sudo docker compose up -d unturned_srv
#start the server in detached mode

sudo docker compose exec unturned_srv screen -dr
#execute the command "screen -dr" into the container instance
#breaking with ctrl-c WILL stop the container
#detach the screen and keep server running with key combo: Ctrl + a + d
#if making a headless update script, this command should be removed

#if server is already running, running this script again will not restart it unless:
    #1. The image was rebuilt i.e. ) sudo docker compose build unturned_srv
    #2. A parameter in unturned_srv service in docker-compose.yml was changed/removed/added