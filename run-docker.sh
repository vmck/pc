#!/bin/bash -ex

cd "$( dirname "${BASH_SOURCE[0]}" )"

docker run --detach --rm \
  --name vmck \
  --env SECRET_KEY=foo \
  --env HOSTNAME='*' \
  --env CONSUL_URL=http://10.42.1.1:8500 \
  --env NOMAD_URL=http://10.42.1.1:4646 \
  --env QEMU_IMAGE_PATH_PREFIX=http://10.42.1.1:10000 \
  --env BACKEND=qemu \
  --network="host" \
  vmck/vmck:0.3.0

docker build --tag=test .
docker run --network="host" --name test --rm test

docker stop vmck
