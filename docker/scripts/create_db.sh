#!/bin/bash

source /root/.bashrc
set -ue

echo "Waiting to complete bundle install..."
sleep 30

until bundle check --dry-run > /dev/null
do
  echo "Waiting to complete bundle install..."
  sleep 5
done

bundle exec rake db:create
