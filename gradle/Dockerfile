FROM lukecottage/base-ops:latest

#ENV DEPENDENCY_CHECK_HOME=/opt/dependency-check
#ENV JAVA_HOME=/usr/local/openjdk-11
#ENV SONAR_SCANNER_HOME=/opt/sonar-scanner
#ENV XDG_CONFIG_HOME=/tmp
#ENV SONAR_SCANNER_HOME=${SONAR_SCANNER_HOME}
#ENV SONAR_USER_HOME=${SONAR_SCANNER_HOME}/.sonar
#ENV PATH=${JAVA_HOME}/bin:${SONAR_SCANNER_HOME}/bin:${NODEJS_HOME}/bin:${DEPENDENCY_CHECK_HOME}/bin:${PATH}
#ENV NODE_PATH=${NODEJS_HOME}/lib/node_modules
#ENV SRC_PATH=/usr/src

RUN apt-get update && apt-get -y install gradle

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
