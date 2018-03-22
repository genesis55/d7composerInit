#!/bin/bash

#### move drupal files to apache htdocs directory ####
#if [ -d "/var/www/html/sites" ]; then
if [ -d "/var/www/html/melanoma/web" ]; then
	echo "Skipping drupal install"
else 

	#cp -R /tmp/drupal-7.52/* /var/www/html
	#### remove drupal dl and change sites permissions ####
	#rm -rf /tmp/drupal-7.52
    #rm -rf /tmp/.htaccess

	#git clone https://github.com/CBIIT/drupal /var/www/html
    #cd /var/www/html
    #cp /tmp/.htaccess /var/www/html

	echo "installing database"
	#chown -R apache:apache /var/www/html/sites 
	#chmod 755 -R /var/www/html/sites
	#chown -R apache:apache /var/www/html/melanoma/web
	#chmod 755 -R /var/www/html/melanoma/web
	#drush site-install -y standard --account-name=admin --account-pass=admin --db-url=mysql://mysql:DBAdmin1@$IPADDRESS/$DB
	cd /var/www/html
	composer create-project drupal-composer/drupal-project:7.x melanoma --stability dev

fi
#### execute supervisor to start apache ####
exec supervisord

