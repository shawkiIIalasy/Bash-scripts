#!/bin/bash

# Reset
Color_Off='\033[0m' # Text Reset

# Regular Colors
Red='\033[0;31m'    # Red
Green='\033[0;32m'  # Green
Yellow='\033[0;33m' # Yellow
Purple='\033[0;35m' # Purple
Cyan='\033[0;36m'   # Cyan

read -p "Enter target php version: (ex: 8.0)"  PHP_TARGET_VERSION
read -p "Enter from php version: (ex: 7.4)" PHP_FROM_VERSION


echo -e "$Yellow \n Marina team $Color_Off"

sudo apt update

sudo apt install software-properties-common && sudo add-apt-repository ppa:ondrej/php -y

sudo apt install php${PHP_TARGET_VERSION} php${PHP_TARGET_VERSION}-propro php${PHP_TARGET_VERSION}-curl php${PHP_TARGET_VERSION}-phpdbg php${PHP_TARGET_VERSION}-gmp php${PHP_TARGET_VERSION}-intl php${PHP_TARGET_VERSION}-yaml php${PHP_TARGET_VERSION}-ps php${PHP_TARGET_VERSION}-uuid php${PHP_TARGET_VERSION}-zip php${PHP_TARGET_VERSION}-grpc php${PHP_TARGET_VERSION}-mysql php${PHP_TARGET_VERSION}-bcmath php${PHP_TARGET_VERSION}-http php${PHP_TARGET_VERSION}-oauth php${PHP_TARGET_VERSION}-psr php${PHP_TARGET_VERSION}-sqlite3 php${PHP_TARGET_VERSION}-xdebug php${PHP_TARGET_VERSION}-raphf php${PHP_TARGET_VERSION}-fpm php${PHP_TARGET_VERSION}-imagick php${PHP_TARGET_VERSION}-mbstring php${PHP_TARGET_VERSION}-opcache php${PHP_TARGET_VERSION}-readline php${PHP_TARGET_VERSION}-xml php${PHP_TARGET_VERSION}-cli php${PHP_TARGET_VERSION}-gd php${PHP_TARGET_VERSION}-mcrypt php${PHP_TARGET_VERSION}-redis php${PHP_TARGET_VERSION}-inotify php${PHP_TARGET_VERSION}-pgsql

echo -e "$Cyan \n Stop PHP ${PHP_FROM_VERSION} $Color_Off"
sudo systemctl stop php${PHP_FROM_VERSION}-fpm
sudo systemctl disable php${PHP_FROM_VERSION}-fpm

cd ~/.config/composer && composer update

echo -e "$Cyan \n Start PHP ${PHP_TARGET_VERSION} $Color_Off"
sudo systemctl start php${PHP_TARGET_VERSION}-fpm
sudo systemctl enable php${PHP_TARGET_VERSION}-fpm

cd ~/.config/composer && composer update

sudo update-alternatives --set php /usr/bin/php${PHP_TARGET_VERSION}


sudo systemctl restart nginx

valet use ${PHP_TARGET_VERSION}
valet restart

echo -e "\n"

echo -e "$Green Finished PHP switched from ${PHP_TARGET_VERSION} to ${PHP_FROM_VERSION} $Color_Off"
