FROM ubuntu:jammy
HEALTHCHECK --interval=30s --timeout=5s CMD echo "Hello World" || exit 1

LABEL "author"="Luca Capanna"
LABEL "licenze"="MIT License"
LABEL "image.version"="0.5.2"
LABEL "image.name"="lukecottage/ops-image"

USER root

### START ENUMERATION PHASE

# Dependency-Check envs
ARG DEPENDENCY_CHECK_URL=https://github.com/jeremylong/DependencyCheck/releases/download/v8.3.1/dependency-check-8.3.1-release.zip
ARG DEPENDENCY_CHECK_ASC=https://github.com/jeremylong/DependencyCheck/releases/download/v8.3.1/dependency-check-8.3.1-release.zip.asc
ARG DEPENDENCY_CHECK_PUBKEY=259A55407DD6C00299E6607EFFDE55BE73A2D1ED

# GOlang envs
ARG GOLANG_URL=https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
ARG GOLANG_SHA256=d7ec48cde0d3d2be2c69203bc3e0a44de8660b9c09a6e85c4732a3f7dc442612

# HELM envs
ARG HELM_URL=https://get.helm.sh/helm-v3.12.1-linux-amd64.tar.gz
ARG HELM_SHA256=1a7074f58ef7190f74ce6db5db0b70e355a655e2013c4d5db2317e63fa9e3dea

# KICS envs
ARG KICS_URL=https://github.com/Checkmarx/kics.git
ARG KICS_VERSION=v1.5.5
ENV KICS_HOME=/opt/kics

# KUBECTL envs
ARG KUBECTL_VERSION="1.27.3"

# Sonar scanner envs
ARG SONAR_SCANNER_URL=https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.8.0.2856-linux.zip
ARG SONAR_SCANNER_ASC=https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.8.0.2856-linux.zip.asc
ARG SONAR_SCANNER_PUBKEY=https://binaries.sonarsource.com/sonarsource-public.key
ENV SONAR_SCANNER_HOME=/usr/local/sonar-scanner
ENV SONAR_USER_HOME=${SONAR_SCANNER_HOME}/.sonar

# SDKMAN envs
ARG SDKMAN_DIR=/usr/local/sdkman

# System envs
ENV PATH=/home/linuxbrew/.linuxbrew/bin:${JAVA_HOME}/bin:${GOLANG_HOME}/bin:${SONAR_SCANNER_HOME}/bin::${DEPENDENCY_CHECK_HOME}/bin:${DEPENDENCY_CHECK_HOME}/bin:${KICS_HOME}/bin:${SDKMAN_DIR}/bin:${HOME}/.krew/bin:${PATH}
ENV JAVA_HOME=/usr/local/openjdk-11
#${NODEJS_HOME}/bin
#ENV NODE_PATH=${NODEJS_HOME}/lib/node_modules
ENV SRC_PATH=/usr/src
ENV XDG_CONFIG_HOME=/tmp

### END ENUMERATION PHASE
### START INIT PHASE

WORKDIR /opt
RUN mkdir -p /opt/scripts
COPY ./scripts/* /opt/scripts/
COPY ./configs/* /opt/configs/
RUN chmod a+x /opt/scripts/*
# Create OPS user and workspace
RUN useradd -rm -d /home/operator -s /bin/bash -g root -G sudo -u 1042 operator
#RUN useradd -ms /bin/bash operator
RUN mkdir -p /workspace && chown operator -R /workspace

# Workout TZ database setup
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Minimum requirements
RUN /opt/scripts/requirements.sh

### END INIT PHASE
### START INSTALL PHASE

# Install Azure CLI
RUN /opt/scripts/install_azurecli.sh

# Install Chef InSpec
RUN /opt/scripts/install_inspec.sh

# Install Dependency-Check (OWASP)
RUN /opt/scripts/install_dependency-check.sh $DEPENDENCY_CHECK_URL $DEPENDENCY_CHECK_ASC

# Install FluxCD CLI
RUN /opt/scripts/install_fluxcd.sh

# Install Hashicorp Tools CLI
RUN /opt/scripts/install_hashicorp.sh

# Install GOlang
RUN /opt/scripts/install_golang.sh $GOLANG_URL $GOLANG_SHA256

# Install Helm CLI
RUN /opt/scripts/install_helm.sh $HELM_URL $HELM_SHA256

# Install KICS
RUN /opt/scripts/install_kics.sh $KICS_URL $KICS_VERSION

# Install kubernetes CLI (and utilies/plugins)
RUN /opt/scripts/install_kubectl.sh $KUBECTL_VERSION

# Install SDKMAN CLI
RUN /opt/scripts/install_sdkman.sh $SDKMAN_DIR

# Install Sonarqube Scanner
RUN /opt/scripts/install_sonar-scanner.sh $SONAR_SCANNER_URL $SONAR_SCANNER_HOME $SONAR_SCANNER_ASC $SONAR_SCANNER_PUBKEY

### END INSTALL PHASE

# Cleanup and setup operator user
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo "operator ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER operator
# Configure Krew for "operator" user
RUN kubectl krew update ; kubectl krew install ktop kubesec-scan resource-capacity

# Install and configure Oh My Zsh for "operator" user
RUN /opt/scripts/zsh.sh

WORKDIR /workspace
CMD ["/bin/bash"]
