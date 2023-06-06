# Unturned Dedicated Server
Utilizing Linux and Docker Containers

Dedicated to my best friend on Discord, Joseph

## System Requirements
This server software was installed in a Ubuntu 22.04 Docker container. Since the server is a container, the host operating system could theoretically be any distribution of Linux that supports Docker and Docker Compose. Git was also used to clone the repository.

## Prerequisites
### 1. Linux host machine or VM to Install Server
We recommend [Ubuntu Server](https://ubuntu.com/download/server) without a GUI. If you prefer a desktop, we recommend [Linux Mint](https://linuxmint.com/download.php).

### 2. Install Docker Engine and Docker Compose
Follow [official guide](https://docs.docker.com/engine/install/ubuntu/). Test installation with version command for Docker and Docker Compose. Output should represent the most current version.
```
docker -v
```
> Docker version 24.0.2, build cb74dfc
```
docker compose version
```
> Docker Compose version v2.18.1

## Clone the Repository
Install git if not already installed
```
sudo apt install -y git
```
Clone the unturned repository to your current location
```
git clone https://github.com/notarobot767/unturned.git
```

## Setup Server Variables
Change directory into the newly cloned repository folder. The default name is called unturned.
```
cd unturned
```
Edit the [.env](.env) file, and set the absolute path to the data directory. Optionally set the server name. This is the name the server will call the file saved to disk, not what is advertised to players. Keep it something short without spaces.

## Usage
All docker compose commands need to be ran within the directory of the [docker-compose.yml](docker-compose.yml) file. For more options on configuring Docker Compose, see the [Docker Compose File Version 3](https://docs.docker.com/compose/compose-file/compose-file-v3/) guide.

### Update the Server
Important: Ensure server is not already running. Ensure data directory in [.env](.env) file is as desired. See the section listed: Stop the Server

This will download the initial server files as well as apply any released updates. The launch parameters are included in command field of the docker-compose file and do not require modification.

The detached flag "-d" was intentionally left off the compose up command so that the server admin can see the update progress. Update may appear to freeze, but that is normal. This container will shutdown upon updating the server files.

The [SteamCMD Docker Image](https://hub.docker.com/r/steamcmd/steamcmd) frequently updates. Highly recommend using the Docker Compose pull command to download the latest version before running the container. SteamCMD application will update itself upon instantiation, but this method will save bandwidth when running multiple instances or other servers that utilize SteamCMD.

```
sudo docker compose pull unturned_update
sudo docker compose up unturned_update
```

### Run the Server
For the initial run, it may be desireable to remove the detached flag "-d" to inspect any errors. The server should normally be ran detached. The interactive console through the screen command is the preferred way to view and interact with the server console.

The server is built with the [Ubuntu Docker Image](https://hub.docker.com/_/ubuntu) 22.04 tag. Theoretically, other 64-bit Linux images would work, but I only tested it with Ubuntu. Other than updates, I only added the ca-certificates and screen package in the [Dockerfile](Dockerfile) for the server. ca-certificates is necessary to TLS connections to communicate with Steam servers. See next section about the screen package. I am unaware of any other necessary packages to run Unturned on Linux.

If not already built, Docker will automatically build the server image. If you make any modifications to the Dockerfile, you will need to rebuild the image for any changes to take effect.
```
sudo docker compose build unturned_srv
```

Finally, run the server with
```
sudo docker compose up -d unturned_srv
```

### Attach the Interactive Console
Normally using the docker compose logs command would be sufficient to monitor container standard output (stdout), but this console is interactive. Therefore, the stdin_open and tty flags were set true in the [docker-compose.yml](docker-compose.yml) section for the server container. The screen utility adds the benefit to be able to pull up the server console from any SSH session. The -d flag will forcible detach a screen, and -r will then attach the open screen session on the given terminal window. The -d flag is necessary for the first time connecting upon launching the server. Subsequently including it in later sessions has no negative effects but could be ran without. Type help in the console to see the available commands.

```
sudo docker compose exec unturned_srv screen -dr
```

### Detach the Interactive Console
Note: This is just a series of keys to press in order. Please don't actually type the "+" symbol.

```
Ctrl + a + d
```

### Stop the Server
```
sudo docker compose stop unturned_srv
```

### Restart the Server
```
sudo docker compose restart unturned_srv
```

## Customize the Server

### Port Forwarding
By default, UDP ports 27015 and 27016 are used. Ensure your router has a rule to forward these ports to your server when clients connect on your public IP address. If you are new to networking, read about the difference between public and private IP address and NAT. Essentially, your home network is likely a private IP address range, and your router has a single public IP address. Public addresses can talk on the internet while private addresses can't. NAT is the mechanism that allows your private addresses to masquerade as your router's single public IP address. Port forwarding is how we enable a public IP to initiate a connection to private IP address, in this case to your Unturned server.

[Official Guide for Port Forwarding](https://docs.smartlydressedgames.com/en/stable/servers/port-forwarding.html)

### Game Server Login Token
Beginning in version 3.20.4.0 Unturned dedicated servers can be authenticated using a Game Server Login Token or GSLT. After version 3.21.31.0 anonymous servers (without GSLT) are hidden from the internet server list.

Follow the [offical guide](https://docs.smartlydressedgames.com/en/stable/servers/game-server-login-tokens.html) to generate a token and apply a token to your server.

### Commands.dat
Find your commands.data file in the data/Servers/[NAME]/Server/Commands.dat

Use a guide such as [nodecraft.com](https://nodecraft.com/support/games/unturned/configuring-your-unturned-server-commands-dat#h-default-single-player-loadouts-de1ae627a) to find the available options

Optional: Set the server owner with the Owner command

### Adminlist.dat
In the same directory as Commands.dat, list server admins by their SteamID64 one per line.