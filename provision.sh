#!/bin/bash

set -ex

sudo apt-get install -yq git
sudo git clone https://github.com/Jokeswar/School-projects.git /opt/vmck/test
cd /opt/vmck/test/TetriBit
sudo make run
