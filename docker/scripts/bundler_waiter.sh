#!/bin/bash

source /root/.bashrc
set -ue

until bundle check --dry-run > /dev/null
do
  echo "Waiting to complete bundle install..."
  sleep 5
done
