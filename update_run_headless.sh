#!/bin/bash

#This script was intended as a draft to point server admins in the right direction
#Edit it to fit your needs for automation
#Refer to the official documentation and learn the docker compose CLI

cd "${0%/*}"
#ensure working directory is the same as the script
#useful if calling script from another location, like a cron job
#https://stackoverflow.com/questions/6393551/what-is-the-meaning-of-0-in-a-bash-script

#purpose
#1. stop running server
#2. update server if needed
#3. start server
#headless script meant to be called in a cron job

sudo docker compose pull unturned_update &>/dev/null
#ensure steamcmd image is latest. It updates frequently
#https://hub.docker.com/r/steamcmd/steamcmd

sudo docker compose stop unturned_srv &>/dev/null
#ensure server is not running

sudo docker compose up unturned_update &>/dev/null
#check for and apply any updates
#container will terminate when update is complete

sudo docker compose up -d unturned_srv &>/dev/null
#start the server in detached mode