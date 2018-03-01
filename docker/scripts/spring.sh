#!/bin/bash

source ~/.bashrc
set -ue

cd /root/myapp

for dotfile in .bash_history .pry_history .my.cnf
do
  ln -sf /root/dotfiles/${dotfile} /root/${dotfile}
done

until bundle check --dry-run > /dev/null
do
  echo "Waiting to complete bundle install..."
  sleep 5
done

rm -rf /tmp/spring-0
bundle exec spring server
