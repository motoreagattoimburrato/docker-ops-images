#!/usr/bin/env bash

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer 
chmod a+x /usr/local/bin/composer

# Check if binary exists
/usr/local/bin/composer --version

if [[ $? -eq 1 ]]
then
    echo "composer not present - check installation steps"
    exit -1 
fi