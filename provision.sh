#!/usr/bin/env bash

set -ex

sudo apt install -yq git
sudo git clone https://github.com/Jokeswar/School-projects.git /opt/vmck/test
cd /opt/vmck/test/TetriBit
sudo make run
