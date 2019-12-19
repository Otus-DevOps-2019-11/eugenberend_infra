# eugenberend_infra
eugenberend Infra repository
# To access someinternal host with bash one-liner,
simply type:
ssh -tA  35.210.209.134 ssh 10.128.0.2
* -t to force pseudo-terminal;
* -A to explicitly use ssh agent tunneling;
# To jump with `ssh someinternal` command,
according to [this](https://wiki.gentoo.org/wiki/SSH_jump_host), edit ~/.ssh/config file on the LOCAL (originating) machine:
```
### First jumphost. Directly reachable
Host bastion
  HostName 35.210.209.134

### Host to jump to via first jumphost
Host someinternalhost
  HostName 10.128.0.2
  ProxyJump  bastion
```
# Regarding bastion, VPN server and someinternal host
The bastion server runs with public IP and private IP.
The someinternal server has only private IP and therefore cannot be accessed directly from the internet.
We have configured Pritunl VPN server and set up VPN connection.
We have configured bastion server to be a jump server for our private GCP network
Thus we can now connect directly to someinternal bypassing bastion SSH jump.
This can be verified by telnet:
```
telnet 10.132.0.2 22
Trying 10.132.0.2...
Connected to 10.132.0.2.
Escape character is '^]'.
SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.8

Protocol mismatch.
```
# Configuration
bastion_IP = 35.210.209.134

someinternalhost_IP = 10.132.0.2
