#!/bin/bash

source /root/.bashrc
set -ue

cd /root/myapp
rm -f /root/myapp/tmp/pids/server.pid

bundle install --path=vendor/bundle -j4
npm install

eval "${COMMAND}"
