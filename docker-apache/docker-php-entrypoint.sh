#!/bin/sh
set -e

if [ ! -f /var/www/html/.env ]; then
   git clone https://github.com/saelos/saelos.git /var/www/html
fi

cd /var/www/html

composer install --no-dev

chown -R www-data:www-data /var/www/html

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- apache2-foreground "$@"
fi

exec "$@"
