#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

export VMCK_URL='http://10.66.60.1:8000'

function clean {
    vagrant destroy -f || echo "vagrant destroy failed, but we don't care"
trap clean  EXIT
}

set -ex

vagrant up
