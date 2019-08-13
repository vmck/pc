#!/bin/bash -ex

cd "$( dirname "${BASH_SOURCE[0]}" )"

export VMCK_URL='http://localhost:8000'

trap "vagrant destroy -f"  EXIT

vagrant up
