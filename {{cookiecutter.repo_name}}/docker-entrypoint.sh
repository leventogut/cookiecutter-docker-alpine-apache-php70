#!/usr/bin/env bash
set -e
DISTRO=alpine

# ----------------------------------------------- common tasks for all commands
if [ "$DISTRO" == "alpine" ]; then
       	# ------------------------------------------------- common tasks for alpine
       	cd app
       	find ! -name .git -exec chown apache:apache {} \;
       	#chown -R apache:apache /app
       	APACHE_EXECUTABLE=httpd
fi
# common tasks trusty
if [ "$DISTRO" == "trusty" ]; then
       	# ------------------------------------------------- common tasks for trusty
       	cd app
       	find ! -name .git -exec chown www-data:www-data {} \;
       	#chown -R www-data:www-data /app
       	source /etc/apache2/envvars
       	APACHE_EXECUTABLE=apache2
fi



# development
if [ "$1" = 'serve-dev' ]; then
       	php /app/artisan config:clear
       	php /app/artisan config:cache
       	php /app/artisan --force migrate
       	php /app/artisan --force db:seed
       	exec ${APACHE_EXECUTABLE} -D FOREGROUND
fi

# production
if [ "$1" = 'serve' ]; then
       	php /app/artisan config:clear
       	php /app/artisan config:cache
       	php /app/artisan --force migrate
       	exec ${APACHE_EXECUTABLE} -D FOREGROUND
fi

if [ "$1" = 'check' ]; then
    ${APACHE_EXECUTABLE} -t
    ${APACHE_EXECUTABLE} -t -D DUMP_VHOSTS
    ${APACHE_EXECUTABLE} -t -D DUMP_RUN_CFG
    ${APACHE_EXECUTABLE} -t -D DUMP_MODULES
    exit 0

fi


# if no recognized command is given let's just run it
exec "$@"