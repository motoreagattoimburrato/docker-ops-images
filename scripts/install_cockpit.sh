#!/usr/bin/env bash

log() {
    echo "[$(date --utc) - $1]: $2"
}

log "INFO" "START 'install_cockpit.sh'"

. /etc/os-release

# Abort if not super user
if [ "$(id -u)" -ne 0 ]; then
    echo "[$(date --utc) - ERROR]: You must have administrative privileges to run this script or must be run as root."
    echo "[$(date --utc) - ERROR]: Try 'sudo ./install_cockpit.sh'"
    exit 1
fi

apt install -t ${VERSION_CODENAME}-backports cockpit

systemctl enable --now cockpit.socket

log "INFO" "|-----------------------------------------------------------------------------------------------------------------|"
log "INFO" "| > INSTALLING Cockpit Applications Package                                                                       |"
log "INFO" "| > Official site: https://cockpit-project.org/                                                                   |"
log "INFO" "| > Official Documentation: https://cockpit-project.org/documentation.html                                        |"
log "INFO" "|-----------------------------------------------------------------------------------------------------------------|"

log "INFO" "Updating apt repositories ..."

curl -sSL https://repo.45drives.com/setup | sudo bash
sudo apt-get update

apt install -t ${VERSION_CODENAME}-backports cockpit-networkmanager
apt install -t ${VERSION_CODENAME}-backports cockpit-ostree
apt install -t ${VERSION_CODENAME}-backports cockpit-machines
apt install -t ${VERSION_CODENAME}-backports cockpit-podman
apt install -t ${VERSION_CODENAME}-backports cockpit-kdump
apt install -t ${VERSION_CODENAME}-backports cockpit-certificates
apt install -t ${VERSION_CODENAME}-backports cockpit-session-recording
apt install -t ${VERSION_CODENAME}-backports subscription-manager-cockpit
apt install -t ${VERSION_CODENAME}-backports cockpit-file-sharing

log "INFO" "Downloading Cockpit-Navigator ..."
wget https://github.com/45Drives/cockpit-navigator/releases/download/v0.5.10/cockpit-navigator_0.5.10-1focal_all.deb
apt install ./cockpit-navigator_0.5.10-1focal_all.deb

log "INFO" "END 'install_cockpit.sh'"


