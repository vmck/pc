#!/bin/bash

docker run --detach --rm \
  --name vmck \
  --env SECRET_KEY=foo \
  --env HOSTNAME='*' \
  --env CONSUL_URL=http://10.42.1.1:8500 \
  --env NOMAD_URL=http://10.42.1.1:4646 \
  --env QEMU_IMAGE_PATH_PREFIX=http://10.42.1.1:10000 \
  --env BACKEND=qemu \
  --publish 10.66.60.1:8000:8000 \
  vmck/vmck

docker build --tag=test .
docker run --name test --rm test

docker stop vmck
