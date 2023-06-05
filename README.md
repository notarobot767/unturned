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
Note: Normally using the docker compose logs command would be sufficient to monitor container standard output (stdout), but this console is interactive. Therefore, the stdin_open and tty flags were set true in the [docker-compose.yml](https://github.com/notarobot767/unturned/blob/main/docker-compose.yml) section for the server container. The screen utility adds the benefit to be able to pull up the server console from any SSH session. The -d flag will forcible detach a screen, and -r will then attach the open screen session on the given terminal window. The -d flag is necessary for the first time connecting upon launching the server. Subsequently including it in later sessions has no negative effects but could be ran without.

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