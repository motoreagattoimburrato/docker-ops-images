#!/usr/bin/env bash

mkdir -p /etc/apt/keyrings
apt-get update
apt-get -y install \
  git \
  jq \
  vim \
  wget \
  unzip \
  gnupg \
  bash \
  shellcheck \
  curl \
  ca-certificates \
  build-essential \
  tar \
  ansible \
  ansible-lint \
  zip \
  bzip2 \
  unzip \
  xz-utils \
  openjdk-11-jdk \
  python3 \
  python3-pip \
  python3-setuptools \
  apache2-utils \
  apt-transport-https \
  htop \
  telnet \
  lsb-release \
  tcpdump \
  siege \
  ncat \
  nmap \
  net-tools \
  sshpass \
  procps \
  file \
  maven \
  gradle \
  zsh \
  pandoc \
  software-properties-common

# Homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /root/.profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bashrc 
echo '# Set PATH, MANPATH, etc., for Homebrew.' >>  /home/operator/.profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>  /home/operator/.bashrc 
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew update