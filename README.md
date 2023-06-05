# Unturned Dedicated Server
Utilizing Linux and Docker Containers

Dedicated to my best friend on Discord, Joseph

## References
[Install Docker Engine and Docker Compose](https://docs.docker.com/engine/install/ubuntu/)

[Docker Compose File Version 3](https://docs.docker.com/compose/compose-file/compose-file-v3/)

[SteamCMD Valve Manual](https://developer.valvesoftware.com/wiki/SteamCMD)

[SteamCMD Docker Image](https://hub.docker.com/r/steamcmd/steamcmd)

[Ubuntu Docker Image](https://hub.docker.com/_/ubuntu)

## System Requirements
This server software was installed in a Ubuntu 22.04 Docker container. Since the server is a container, the host operating system could theoretically be any distribution of Linux that supports Docker and Docker Compose. Git was also used to clone the repository.

## Clone the Repository
```
git clone https://github.com/notarobot767/unturned.git
```

## Setup Server Variables
In the [.env](https://github.com/notarobot767/unturned/blob/main/.env) file, set the absolute path to the data directory. Optionally set the server name. This is the name the server will call the file saved to disk, not what is advertised to players. Keep it something short without spaces.

## Usage
All docker compose commands need to be ran within the directory of the [docker-compose.yml](https://github.com/notarobot767/unturned/blob/main/docker-compose.yml) file.

### Update the Server

This will download the initial server files as well as apply any released updates.

Important: Ensure server is not already running. Ensure data directory in [.env](https://github.com/notarobot767/unturned/blob/main/.env) file is as desired.

Note: The detached flag "-d" was intentionally left off so that the server admin can see the update progress. Update may appear to freeze, but that is normal. This container will shutdown upon updating the server files.

```
sudo docker compose up unturned_update
```

### Run the Server
Note: For the initial run, it may be desireable to remove the detached flag "-d" to inspect any errors. The server should normally be ran detached. The interactive console through the screen command is the preferred way to view and interact with the server console.

```
sudo docker compose up -d unturned_srv
```

### Attach the Interactive Console
Note: Normally using the docker compose logs command would be sufficient to monitor container standard output (stdout), but this console is interactive. Therefore, the stdin_open and tty flags were set true in the [docker-compose.yml](https://github.com/notarobot767/unturned/blob/main/docker-compose.yml) section for the server container. The screen utility adds the benefit to be able to pull up the server console from any SSH session. The -d flag will forcible detach a screen, and -r will then attach the open screen session on the given terminal window. The -d flag is necessary for the first time connecting upon launching the server. Subsequently including it in later sessions has no negative effects but could be ran without. Type help in the console to see the available commands.

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
By default, UDP ports 27015 and 27016 are used. Ensure your router has a rule to forward these ports to your server when clients connect on your public IP address. If you are new to networking, read about the difference between public and private IP address and NAT. Essentially, your home network is likely a private IP address ranged, and your router has a single public IP address. Public addresses can talk on the internet while private addresses can't. NAT is the mechanism that allows your private addresses to all masquerade as your router's single public IP address. Port forwarding is how we enable a public IP to initiate a connection to private IP, in this case to your Unturned server.

[Official Guide for Port Forwarding](https://docs.smartlydressedgames.com/en/stable/servers/port-forwarding.html)

### Game Server Login Token
Beginning in version 3.20.4.0 Unturned dedicated servers can be authenticated using a Game Server Login Token or GSLT. After version 3.21.31.0 anonymous servers (without GSLT) are hidden from the internet server list.

Follow the [offical guide](https://docs.smartlydressedgames.com/en/stable/servers/game-server-login-tokens.html) to generate a token and apply a token to your server.

### Commands.dat
Find your commands.data file in the data/Servers/[NAME]/Server/Commands.dat

Use a guide such as [nodecraft.com](https://nodecraft.com/support/games/unturned/configuring-your-unturned-server-commands-dat#h-default-single-player-loadouts-de1ae627a) to find the available options

Optional: Set the server owner with the Owner command

### Adminlist.dat
In the same directory as Commands.dat, list server admins by their SteamID64 one per line