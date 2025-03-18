# Using the test environment

## Introduction

A custom [Docker image](Dockerfile) is provided.
It is used to create a testing environment composed of 6 containers within a private network.

This document outlines the container utilized for testing purposes, along with the accompanying script that automates the setup of the testing environment.

## The Docker container

### Building the image

```bash
cd test-env
SET CONTAINER_NAME="ssh-tunneling"
docker build --tag %CONTAINER_NAME% --progress=plain .
```

### Starting a container

```bash
SET CONTAINER_NAME="ssh-tunneling"
docker run --detach ^
           --net=test_network ^
           --interactive ^
           --tty ^
           --rm ^
           --publish 2222:22/tcp ^
           %CONTAINER_NAME%
```

## The script that automates the setup of the testing environment

The script [start-net.bat](start-net.bat) creates a _bridge_ networt (as defined [here](https://docs.docker.com/reference/cli/docker/network/create/)) and launchs 6 containers within this network.

Each container is assigned an IP address (within the previously crated bridge network).

| **container* | **IP address**   |
|--------------|------------------|
| host1        | 192.168.1.10     |
| host2        | 192.168.1.11     |
| gateway1     | 192.168.1.12     |
| host3        | 192.168.1.13     |
| gateway2     | 192.168.1.14     |
| host4        | 192.168.1.15     |

Important Note:

Please be aware that the SSH configuration of the official Ubuntu image, which serves as the base for the image used in testing, has been customized:

Within the SSHD configuration file (`/etc/ssh/sshd_config`), the parameter `GatewayPorts` is set to `yes`.

> **GatewayPorts** (see [https://man.openbsd.org/sshd_config#GatewayPorts](https://man.openbsd.org/sshd_config#GatewayPorts))
>
> Specifies whether remote hosts are allowed to connect to ports forwarded for the client. By default, sshd(8)
> binds remote port >forwardings to the loopback address. This prevents other remote hosts from connecting to
> forwarded ports. GatewayPorts can be used to specify that sshd should allow remote port forwardings to bind
> to non-loopback addresses, thus allowing other hosts to connect. The argument may be no to force remote port
> forwardings to be available to the local host only, yes to force remote port forwardings to bind to the wildcard
> address, or clientspecified to allow the client to select the address to which the forwarding is bound.
> The default is no.

## Troubleshooting

List the TCP port used on a host:

	sudo netstat -tulpn | grep LISTEN

Associate the processes to the open TCP ports:

	sudo lsof -i -P -n | grep LISTEN

## Notes for Windows

Path to the CLI executable: `C:\Program Files\Docker\Docker`

> Must be added to the environment variable.

```
> where docker
C:\Program Files\Docker\Docker\resources\bin\docker
C:\Program Files\Docker\Docker\resources\bin\docker.exe
```

Before you can build the image, or run a container, you must start the Docker Deamon. This is done through the GUI.

## Resources

* [StackOverflow](https://stackoverflow.com/questions/75675823/docker-build-script-to-execute-does-not-exist-but-it-actually-exists-works): a workaround for a strange problem on Windows only.
* [StackOverflow](https://stackoverflow.com/questions/54397706/how-to-output-a-multiline-string-in-dockerfile-with-a-single-command): multiline string in a `Dockerfile`.
