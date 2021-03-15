FROM gradle:6.5-jdk8

ENV DEBIAN_FRONTEND noninteractive

ENV ANDROID_HOME=/opt/android-sdk-linux
ENV ANDROID_SDK_HOME=${ANDROID_HOME}
ENV ANDROID_SDK_ROOT=${ANDROID_HOME}
ENV ANDROID_SDK=${ANDROID_HOME}

ENV PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
ENV PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/tools/bin"
ENV PATH="${PATH}:${ANDROID_HOME}/tools/bin"
ENV PATH="${PATH}:${ANDROID_HOME}/build-tools/30.0.2"
ENV PATH="${PATH}:${ANDROID_HOME}/platform-tools"
ENV PATH="${PATH}:${ANDROID_HOME}/emulator"
ENV PATH="${PATH}:${ANDROID_HOME}/bin"

ENV JAVA_HOME=/opt/java/openjdk
ENV SONAR_SCANNER_HOME=/opt/sonar-scanner
ENV XDG_CONFIG_HOME=/tmp
ENV SONAR_SCANNER_HOME=${SONAR_SCANNER_HOME}
ENV SONAR_USER_HOME=${SONAR_SCANNER_HOME}/.sonar
ENV PATH=${JAVA_HOME}/bin:${SONAR_SCANNER_HOME}/bin:${NODEJS_HOME}/bin:${PATH}
ENV NODE_PATH=${NODEJS_HOME}/lib/node_modules
ENV SRC_PATH=/usr/src

WORKDIR /opt

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y install git jq vim wget unzip gnupg bash shellcheck curl \
                          build-essential nodejs npm python3 python3-pip expect \
                          libc6:i386 libgcc1:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 \
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

# Install Android SDK

RUN groupadd android && useradd -d /opt/android-sdk-linux -g android android

COPY tools /opt/tools
COPY licenses /opt/licenses

WORKDIR /opt/android-sdk-linux

RUN /opt/tools/entrypoint.sh built-in

RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "cmdline-tools;latest"
RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "build-tools;30.0.2"
RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "platform-tools"
RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "platforms;android-30"
RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "system-images;android-30;google_apis;x86_64"

RUN mkdir /workspace
WORKDIR /workspace

CMD ["/bin/bash"]
