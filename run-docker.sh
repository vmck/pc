#!/usr/bin/env bash

docker rmi test
docker build --tag=test .
docker run --name=test --rm test
