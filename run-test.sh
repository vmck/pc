#!/usr/bin/env bash

set -ex

cd "$( dirname "${BASH_SOURCE[0]}" )"

export VAGRANT_DOTFILE_PATH=$(mktemp -d --tmpdir VAGRANT_DOTFILE_XXXXXXXX)
export VAGRANT_DEFAULT_PROVIDER=vmck
export VAGRANT_CHECKPOINT_DISABLE=true
export VAGRANT_BOX_UPDATE_CHECK_DISABLE=true
export VMCK_URL="http://10.42.1.1:9990/"

TIMEOUT_MIN=23
RETRIES=1

function print_section() {
  set +x
  echo
  echo '-----------------------------------------'
  echo "| $1"
  echo '-----------------------------------------'
  set -x
}

function vagrant_up() {
  set +e
  vagrant up --no-provision || echo "vagrant up failed, VM might still work"
  echo "sudo shutdown +$TIMEOUT_MIN" | vagrant ssh -- -v
  sshret=$?
  if [ 0 -eq $sshret ]; then
    return 0
  else
    vagrant destroy -f
    return 1
  fi
}

function retry_vagrant_up() {
  for i in $(seq 1 $RETRIES); do
    print_section "Starting vagrant... (try #$i/$RETRIES)"
    if vagrant_up; then
      return 0
    fi
  done
  echo "Vagrant failed after $RETRIES tries"
  exit 1
}

retry_vagrant_up

print_section "Run Script"
set +e
vagrant provision
ret=$?


print_section "Doing tests"
vagrant ssh <<'EOF'
set -e
ls -al /opt/vmck
EOF
ret=$?

print_section "Destroying Vagrant"
vagrant destroy -f || echo "vagrant destroy failed, but we don't care"
exit $ret
