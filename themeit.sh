#For now, all project names are d7nci.  It can be changed later.
#Need a constant for now so that the git submodules work with static address. 

PROJECT_NAME=$1
MYSQL_USERNAME=$2
MYSQL_PASSWORD=$3
IP=$4

MYSQL_DRUPAL_DATABASE=$PROJECT_NAME
DRUPAL_ADMIN_PASSWORD=Admin\!1

if [ "$MYSQL_PASSWORD" == "" ]; then
	echo
	echo "SYNTAX:"
	echo "themeit.sh <project name> <mysql user> <mysql password>"
	echo 
	exit 1
fi

composer create-project drupal-composer/drupal-project:7.x $PROJECT_NAME --stability dev
#Add multiproject-theme module as submodule
git submodule add https://github.com/CBIIT/drupal-multipurpose-theme.git $PROJECT_NAME/web/sites/all/themes/drupal-multipurpose-theme

cd $PROJECT_NAME

echo "Install database with drush"
#Add database
echo "Creating Initial Drupal Database:"
echo "  MYSQL_DRUPAL_DATABASE: $MYSQL_DRUPAL_DATABASE"
echo "  MYSQL_USERNAME: $MYSQL_USERNAME"
echo "  MYSQL_PASSWORD: $MYSQL_PASSWORD"

#Tried for 3 hours to auto create databse with the following command.
#We will import a standard initial database for now.
#drush -y si --db-url=mysql://$MYSQL_USERNAME:$MYSQL_PASSWORD@127.0.0.1:3306/$MYSQL_DRUPAL_DATABASE --account-pass=$DRUPAL_ADMIN_PASSWORD

mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -h$IP -e"drop database $PROJECT_NAME;"
mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD  -h$IP -e"create database $PROJECT_NAME;"
#echo "mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD $PROJECT_NAME < assets/d7composer.sql;""
mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD  -h$IP $PROJECT_NAME < ../assets/d7composer.sql;
mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD  -h$IP -e"show databases;"


#cp assets/settings.php
echo "Changing setting databse to correct project name"
cp ../assets/settings.php .
chmod 775 settings.php
echo "Changing database name in settings.php to $PROJECT_NAME"
sed -i .bak "s/d7composer/$PROJECT_NAME/" settings.php
sudo rm web/sites/default/settings.php
sudo mv settings.php web/sites/default/
sudo chmod 444 web/sites/default/settings.php

#drush cr

echo "Your new Project is ready"
echo "Change Diretory to $PROJECT_NAME to view the files"
