[![Build Status](https://travis-ci.com/Otus-DevOps-2019-11/eugenberend_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2019-11/eugenberend_infra)

## Feature list

- [x] Created VMs with vagrant. Installed app on these VMs
- [x] Configured redirection to http port
- [x] Created virtualenv for molecule tests (excluded from repository)
- [x] Added test to prove tcp/27017 responds (excluded from repository):
```python
# check if listening on 27017
def test_port(host):
    address = host.addr("localhost")
    assert address.port(27017).is_reachable
```
- [x] Configured Travis for extended check (partially)

## How to use

Create virtual machines with fully provisioned app:

```shell
cd ansible && vagrant up
```

Check http://10.10.10.20 responds.
