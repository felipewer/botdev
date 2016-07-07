# Bot development container

Container for bot server development using nodejs.

## Prerequisites

You must have a ssh server facing the internet running someplace.

Ex.:

Using a Digital Ocean droplet with CoreOS you can start an ssh server container:

```
docker run -d \
    -p 3001:3001 \
    -p 2200:22 \
    --name ssh-tunnel \
    -e SSH_PUBKEY="ssh-rsa AAAA....jzsAN9D" \
    cloudgear/dev-ssh:1.0.0
```

## Clonning the repo

If it does not exist yet, create a `workspace` folder inside your user's home and then clone the repository:

```
mkdir -p ~/workspace
cd ~/workspace
git clone ...
```

## Generating the container image

Enter the `docker` folder and generate the image:

```
cd ~/workspace/botdev/docker
docker build -t botdev .
```

## Run the Container

```
cd ~/workspace/botdev
./run.sh
```

## Configure SSH-Tunnel

[ Outside of the container ]

Follow [GitHub's instructions](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) to generate an SSH key pair. Pay attention to the part where you can choose a file name for the key (Ex.: digiocean).

### Create config file

Create the file `~/.ssh/config` with the content below. Change the hostname field accordingly.

```
Host digitalocean
    HostName <droplet_address>
    User core
    IdentityFile ~/.ssh/digiocean

Host ssh-tunnel
    HostName <droplet_address>
    User root
    IdentityFile ~/.ssh/digiocean
```

## Open ssh-tunnel

```
ssh -N -R 3001:localhost:3000 ssh-tunnel -p 2200
```

As long as the tunnel is open, your node server running on port 3000 inside the **botdev** container will be acessible from anywhere on `<droplet_address>:3001`
