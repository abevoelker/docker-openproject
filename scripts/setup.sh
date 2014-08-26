#!/usr/bin/env bash
export RAILS_ENV=${RAILS_ENV:-production}
source /etc/profile.d/ruby.sh

cd /var/www/openproject &&\
  echo -e "\nCreating database..." &&\
  PGPASSWORD=$POSTGRES_ENV_PASS psql -h $POSTGRES_PORT_5432_TCP_ADDR -d postgres -f /var/www/openproject/docker/scripts/create_database.sql -U $POSTGRES_ENV_USER &&\
  echo -e "\nGenerating secret token..." &&\
  bundle exec rake generate_secret_token &&\
  echo -e "\nRunning database migrations..." &&\
  bundle exec rake db:migrate &&\
  echo -e "\nSeeding database..." &&\
  bundle exec rake db:seed &&\
  echo -e "\nPrecompiling assets..." &&\
  bundle exec rake assets:precompile &&\
  touch /var/www/openproject/.setup-complete
