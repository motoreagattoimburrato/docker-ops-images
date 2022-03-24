FROM lukecottage/base:latest

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV DEPENDENCY_CHECK_HOME=/opt/dependency-check
ENV SONAR_SCANNER_HOME=/opt/sonar-scanner
ENV XDG_CONFIG_HOME=/tmp
ENV SONAR_SCANNER_HOME=${SONAR_SCANNER_HOME}
ENV SONAR_USER_HOME=${SONAR_SCANNER_HOME}/.sonar
ENV PATH=${JAVA_HOME}/bin:${SONAR_SCANNER_HOME}/bin:${NODEJS_HOME}/bin:${DEPENDENCY_CHECK_HOME}/bin:${PATH}
ENV NODE_PATH=${NODEJS_HOME}/lib/node_modules
ENV SRC_PATH=/usr/src

# Workout TZdata
ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /opt

RUN apt-get update \
    && apt-get -y install git jq vim wget unzip gnupg bash shellcheck curl tar ca-certificates \
                  build-essential nodejs npm python3 python3-pip zip bzip2 unzip xz-utils openjdk-11-jdk \
                  php7.4 php7.4-bcmath php7.4-bz2 php7.4-cgi php7.4-cli php7.4-common php7.4-curl \
                  php7.4-dba php7.4-dev php7.4-enchant php7.4-fpm php7.4-gd php7.4-gmp php7.4-imap \
                  php7.4-interbase php7.4-intl php7.4-json php7.4-ldap php7.4-mbstring php7.4-mysql \
                  php7.4-odbc php7.4-opcache php7.4-pgsql php7.4-phpdbg php7.4-pspell php7.4-readline \
                  php7.4-snmp php7.4-soap php7.4-sqlite3 php7.4-sybase php7.4-tidy php7.4-xml php7.4-xmlrpc \
                  php7.4-xsl php7.4-zip php-xdebug php-codecoverage phpunit \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g typescript@3.7.5 \
    && pip3 install --no-cache-dir pylint

# Install OWASP Dependency-Check
RUN wget -q -O /opt/dependency-check.zip https://github.com/jeremylong/DependencyCheck/releases/download/v6.1.2/dependency-check-6.1.2-release.zip \
    && unzip /opt/dependency-check.zip && rm -rf /opt/dependency-check.zip

# Install Sonarqube Scanner 4.6
RUN wget -q -O /opt/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.0.2311-linux.zip \
    && wget -q -O /opt/sonar-scanner.zip.asc https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.0.2311-linux.zip.asc \
    && wget -q -O /opt/sonarsource-public.key https://binaries.sonarsource.com/sonarsource-public.key \
    && gpg --import /opt/sonarsource-public.key \
    && gpg --verify /opt/sonar-scanner.zip.asc /opt/sonar-scanner.zip \
    && unzip sonar-scanner.zip \
    && rm -rf sonar-scanner.zip sonar-scanner.zip.asc \
    && mv sonar-scanner-4.6.0.2311-linux ${SONAR_SCANNER_HOME}

RUN mkdir /workspace
WORKDIR /workspace

# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod a+x /usr/local/bin/composer

# Missing CA chain
RUN curl https://www.actalis.it/documenti-it/actalisorganizationvalidatedservercag3.aspx > /usr/local/share/ca-certificates/cacerts.crt && update-ca-certificates

CMD ["/bin/bash"]
