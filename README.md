# pc

[![Build Status](https://jenkins.liquiddemo.org/api/badges/vmck/pc/status.svg)](https://jenkins.liquiddemo.org/vmck/pc)

## Usage:

```shell
./run-docker.sh
```
And this will build and start the docker image with vagrant-vmck and an instance of vmck. To use another
image than the one that is given to the qemu backend change `vmck.config.image_path`.
