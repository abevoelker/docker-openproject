#!/usr/bin/env bash

cd /var/www/openproject &&\
  exec su openproject -c "/var/www/openproject/docker/scripts/env.sh bundle exec script/delayed_job run --exit-on-complete"
