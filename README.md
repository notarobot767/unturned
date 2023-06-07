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
Edit the [.env](.env) file, and set the path to store persistent server data. The default is the local directory, data. Optionally set the server name. This is the name the server will call the file saved to disk, not what is advertised to players. Keep it something short without spaces.

> UNTURNED_DATA_DIR="./data"

> SERVER_NAME=human

> #edit these variables to match your server


## Usage
I have supplied a series of scripts to help with server management.

[update.sh](update.sh) |
[run.sh](run.sh) |
[stop.sh](stop.sh) |
[restart.sh](restart.sh) | 
[update_run_headless.sh](update_run_headless.sh)

They are intended as a draft to point server admins in the right direction. Edit them to fit your needs for automation. Refer to the official documentation and learn the docker compose.

[Docker Compose File Version 3](https://docs.docker.com/compose/compose-file/compose-file-v3/) |
[Docker Compose CLI](https://docs.docker.com/compose/reference/)

### Update the Server
[update.sh](update.sh) will download the initial server files as well as apply any released updates. The launch parameters are included in command field of the [docker-compose.yml](docker-compose.yml) file and do not require modification.

The update may appear to freeze, but that is normal. This container will shutdown upon updating the server files.

```
sudo ./update.sh
```

### Run the Server
The server is built with the [Ubuntu Docker Image](https://hub.docker.com/_/ubuntu) 22.04 tag. Theoretically, other 64-bit Linux images would work, but I only tested it with Ubuntu. Other than updates, I only added the [ca-certificates](https://packages.ubuntu.com/jammy/ca-certificates) and [screen](https://packages.ubuntu.com/jammy/screen) packages in the [Dockerfile](Dockerfile) for the server. ca-certificates is necessary to TLS connections to communicate with Steam servers. Screen will allow us to keep the server console contained in what is called a screen to be attached or detached on a given terminal. I am unaware of any other necessary packages to run Unturned on Linux.

If not already built, [run.sh](run.sh) will automatically build the server image. If you make any modifications to the Dockerfile, you will need to manually rebuild the image for any changes to take effect.

```
sudo docker compose build unturned_srv
```

Finally, run the server with
```
sudo ./run.sh
```

Upon startup, the server will be put in a screen and attached to your terminal. Note that a break command will terminate the server. Detach the screen and keep the server running by typing the following key command:

```
Ctrl + a + d
```

Note: This is just a series of keys to press in order. Please don't actually type the "+" symbol.

Normally using the docker compose logs command would be sufficient to monitor container standard output (stdout), but this console is interactive. Therefore, the stdin_open and tty flags were set true in the [docker-compose.yml](docker-compose.yml) section for the server container. The screen utility adds the benefit to be able to pull up the server console from any SSH session. The -d flag will forcible detach a screen, and -r will then attach the open screen session on the given terminal window. The -d flag is necessary for the first time connecting upon launching the server. Subsequently including it in later sessions has no negative effects but could be ran without. Type help in the console to see the available commands.

### Stop the Server
Rather then sending a break command in an attached screen, you can alternatively stop a server running in the background with [stop.sh](stop.sh).
```
sudo ./stop.sh
```
> [+] Stopping 1/1

>  ✔ Container unturned-unturned_srv-1  Stopped

### Restart the Server
Restart the server using [restart.sh](restart.sh). This will NOT attach a screen instance on the given terminal; however, feel free to modify this script to do so. This is useful as [run.sh](run.sh) will not restart an already running server instance. This is true as long as the image was not rebuilt or parameters for unturned_srv in the [docker-compose.yml](docker-compose.yml) were not changed, updated, or removed.

```
sudo ./restart.sh
```
> [+] Restarting 1/1

> ✔ Container unturned-unturned_srv-1  Started

### Update and then Restart the Server
[update_run_headless.sh](update_run_headless.sh) will safely and without output, update then restart the server. This is ideally the kind of script to use for automation.

```
sudo ./update_run_headless.sh
```

## Customize the Server
### Port Forwarding
By default, UDP ports 27015 and 27016 are used. Ensure your router has a rule to forward these ports to your server when clients connect on your public IP address. If you are new to networking, read about the difference between public and private IP address and NAT. Essentially, your home network is likely a private IP address range, and your router has a single public IP address. Public addresses can talk on the internet while private addresses can't. NAT is the mechanism that allows your private addresses to masquerade as your router's single public IP address. Port forwarding is how we enable a public IP to initiate a connection to private IP address, in this case to your Unturned server.

[Official Guide for Port Forwarding](https://docs.smartlydressedgames.com/en/stable/servers/port-forwarding.html)

### Game Server Login Token
Beginning in version 3.20.4.0 Unturned dedicated servers can be authenticated using a Game Server Login Token or GSLT. After version 3.21.31.0 anonymous servers (without GSLT) are hidden from the internet server list.

Follow the [official guide](https://docs.smartlydressedgames.com/en/stable/servers/game-server-login-tokens.html) to generate a token and apply a token to your server.

### Commands.dat
Find your commands.dat file in the data/Servers/[NAME]/Server/Commands.dat

Use a guide such as [nodecraft.com](https://nodecraft.com/support/games/unturned/configuring-your-unturned-server-commands-dat#h-default-single-player-loadouts-de1ae627a) to find the available options

Optional: Set the server owner with the Owner command

### Adminlist.dat
In the same directory as Commands.dat, list server admins by their SteamID64 one per line.