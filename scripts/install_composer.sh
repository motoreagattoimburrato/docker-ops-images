#!/usr/bin/env bash

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer && chmod a+x /usr/local/bin/composer
