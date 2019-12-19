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
