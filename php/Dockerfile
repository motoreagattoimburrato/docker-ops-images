FROM lukecottage/base-ops:latest

#ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
#ENV DEPENDENCY_CHECK_HOME=/opt/dependency-check
#ENV SONAR_SCANNER_HOME=/opt/sonar-scanner
#ENV XDG_CONFIG_HOME=/tmp
#ENV SONAR_SCANNER_HOME=${SONAR_SCANNER_HOME}
#ENV SONAR_USER_HOME=${SONAR_SCANNER_HOME}/.sonar
#ENV PATH=${JAVA_HOME}/bin:${SONAR_SCANNER_HOME}/bin:${NODEJS_HOME}/bin:${DEPENDENCY_CHECK_HOME}/bin:${PATH}
#ENV NODE_PATH=${NODEJS_HOME}/lib/node_modules
#ENV SRC_PATH=/usr/src

RUN apt-get update && apt-get -y install \
      php7.4 php7.4-bcmath php7.4-bz2 php7.4-cgi php7.4-cli php7.4-common php7.4-curl \
      php7.4-dba php7.4-dev php7.4-enchant php7.4-fpm php7.4-gd php7.4-gmp php7.4-imap \
      php7.4-interbase php7.4-intl php7.4-json php7.4-ldap php7.4-mbstring php7.4-mysql \
      php7.4-odbc php7.4-opcache php7.4-pgsql php7.4-phpdbg php7.4-pspell php7.4-readline \
      php7.4-snmp php7.4-soap php7.4-sqlite3 php7.4-sybase php7.4-tidy php7.4-xml php7.4-xmlrpc \
      php7.4-xsl php7.4-zip php-xdebug php-codecoverage phpunit

# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod a+x /usr/local/bin/composer

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
