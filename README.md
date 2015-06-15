## Deploy container
Containerized environment to configure/ deploy to staging.

## Configuration
* FLEETCTL_STRICT_HOST_KEY_CHECKING
* FLEETCTL_TUNNEL
* FLEETCTL_ENDPOINT


## Build
~~~bash
docker build -t service-deployer .
~~~
## Fleetctl

* Connect manual to container
~~~bash
docker run -i --rm  -e FLEETCTL_TUNNEL=185.19.218.98 \
    -e FLEETCTL_ENDPOINT=http://127.0.0.1:2379 \
    -v $(pwd)/keys/staging-user:/opt/scripts/coreos_ssh_key:ro \
    -v $(pwd):/opt/scripts/out \
    -t service-deployer \
    bash
~~~
With `-v` you mount the private key to access CoreOS into the container at `:/opt/scripts/coreos_ssh_key`.

 
## Conventions
The service *name* is used for artifacts, service configurations, topics etc. Therefore we should make sure does not contain the `-service` suffix. For example: `ebics-service` has name: `ebics`

### Resources
Unit files [Systemd](http://www.freedesktop.org/software/systemd/man/systemd.unit.html)

* Generate SSH keys
~~~bash
ssh-keygen -f staging-user
~~~
