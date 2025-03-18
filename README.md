# SSH tunneling explained

## Introduction

This document presents the use of OpenSSH for SSH tunneling.

Notations:

    <(local|remote) entry socket> = [<entry IP>:]<entry port>
    <(local|remote) exit socket> = <exit IP>:<exit port>

The default entry IP is `localhost`.

All data sent to the entry socket is forwarded to the exit socket.

## Local port forwarding

    ssh -L <local entry socket>:<remote exit socket> <user>@<gateway>

On the host where the command is issued:

* The SSH client opens a connection to the SSH server running on the host that acts as a gateway (`<user>@<gateway>`).
* The SSH client creates a socket (the entry socket) which is used to listen for an incoming connection request.

On the host that acts as a gateway:

* The SSH server opens a connection to the exit socket.
  Please note that the exit socket should be listening (for a connection request).
  In other words, there should be a server running and waiting for a connection on the exit socket.

Then all data sent to the entry socket is forwarded to the SSH server running on the host that acts as a gateway, which, in turns, forwards it to the exit socket.

> By default, the client running on the host where the command is issued accepts only one connection on the entry socket.
> In order to make it accept more than one connection, you need to specify the command line option `-N`.

![](illustration/local-forwarding.png)

Click [here](local-port-forwarding.md) to get details and examples.

## Remote port forwarding

    ssh -R <remote entry socket>:<local exit socket> <user>@<gateway>

On the host where the command is issued:

* The SSH client opens a connection to the host that acts as a gateway (`<user>@<gateway>`).
* The SSH client opens a connection to the exit socket.
  Please note that the exit socket should be listening (for a connection request).
  In other words, there should be a server running and waiting for a connection on the exit socket.

On the host that acts as a gateway:

* The SSH server creates the entry socket and listens for incoming connection requests on this socket.

Then all data sent to the entry socket is forwarded to the SSH client running on the host where the command is issued, which, in turns, forwards it to the exit socket.

> The SSH server running on the host that acts as a gateway accepts multiple connection requests.

![](illustration/remote-forwarding.png)

Click [here](remote-port-forwarding.md) to get details and examples.

