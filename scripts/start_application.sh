#!/usr/bin/env bash
export RAILS_ENV=${RAILS_ENV:-production}

if [ ! -f /var/www/openproject/.setup-complete ]; then
  echo -e "\nSetup has not been completed. Running setup now..."
  su -c "/var/www/openproject/docker/scripts/setup.sh" openproject
  echo -e "\nSetup complete!\n"
fi

echo -e "\nBooting application..."
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf -n
