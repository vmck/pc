# pc

## Usage:

Run:
```shell
./cluster.py
```
This will start vmck on the nomad cluster.

```shell
./run-docker.sh
```
And this will build and start the docker image with vagrant-vmck. To use another
image than the one that is given to the qemu backend change `vmck.config.image_path`.
