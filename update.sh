#!/bin/bash

#This script was intended as a draft to point server admins in the right direction
#Edit it to fit your needs for automation
#Refer to the official documentation and learn the docker compose CLI

cd "${0%/*}"
#ensure working directory is the same as the script
#useful if calling script from another location, like a cron job
#https://stackoverflow.com/questions/6393551/what-is-the-meaning-of-0-in-a-bash-script

#purpose
#stop server instance
#update server
#send stdout to output

sudo docker compose pull unturned_update
#ensure steamcmd image is latest. It updates frequently
#https://hub.docker.com/r/steamcmd/steamcmd

sudo docker compose stop unturned_srv
#ensure server is not running

sudo docker compose up -d unturned_update
#check for and apply any updates
#-d will run in detached mode
#container will terminate when update is complete
#run.sh should not be scripted to immediately this script run after
    #bc the udpate may still be running in the background
#to get around this, remove the detach "-d" flag

sudo docker compose logs -f unturned_update
#send update logs to standard out
#breaking with ctrl-c does not stop the container
#if making a headless update script, this command should be removed