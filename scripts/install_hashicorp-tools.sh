#!/usr/bin/env bash
set -e

# Setup error handling and cleanup
trap 'echo "An error occurred. Exiting..."; exit 1' ERR
#trap 'rm -rf /tmp/*' EXIT

log() {
    echo "[$(date --utc) - $1]: $2"
}

log "INFO" "START 'install_hashicorp-tools.sh'"

KEYRING_PATH="/usr/share/keyrings/hashicorp-archive-keyring.gpg"
#HASHICORP_TERRAFORM_VERSION="$1"
while [ $# -gt 0 ]; do
    case "$1" in
        --apt-url=*) HASHICORP_APT_REPOSITORY="${1#*=}" ;;
        --gpg-url=*) HASHICORP_APT_PUBKEY="${1#*=}" ;;
        --help)
            echo "Usage: ./install_hashicorp-tools.sh --url=[URL] --asc-key=[ASC_KEY_URL] --pubkey=[PUBKEY] --home=[INSTALL_DIRECTORY]"
            echo "Required arguments:"
            echo "  --apt-url    URL of Hashicorp APT repository"
            echo "  --gpg-url    URL of Hashicorp APT GPG/Keyring repository"
            echo "Optional arguments:"
            echo "  --help       Display this help and exit."
            exit 0
            ;;
        *)
            log "ERROR" "Invalid argument $1"
            exit 1
            ;;
    esac
    shift
done

if [ "$(id -u)" -ne 0 ]; then
    log "ERROR" "You must have administrative privileges to run this script."
    log "ERROR" "Try 'sudo ./install_hashicorp-tools.sh'..."
    log "ERROR" "Aborting..."
    exit 1
fi

if [ -z "$HASHICORP_APT_REPOSITORY" ]; then
    log "ERROR" "--apt-url argument is not defined or is empty. Aborting..."
    exit 1
fi

if [ -z "$HASHICORP_APT_PUBKEY" ]; then
    log "ERROR" "--gpg-url argument is not defined or is empty. Aborting..."
    exit 1
fi

log "INFO" "|-----------------------------------------------------------------------------------------------------------------|"
log "INFO" "| > INSTALLING HASHICORP UNIX TOOLS CLI                                                                             |"
log "INFO" "| > Official site: https://docs.sonarsource.com/sonarqube/latest/                                                 |"
log "INFO" "| > CLI documentation: https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/scanners/sonarscanner/ |"
log "INFO" "|-----------------------------------------------------------------------------------------------------------------|"

log "INFO" "Check if requirements binaries are present and installed if not - wget, unzip, gpg, openjdk-17-jdk - using APT"
for cmd in wget gpg lsb-release; do
    if command -v $cmd &> /dev/null; then
        log "WARN" "$cmd is already installed, skip installation..."
    else
        log "INFO" "Now installing $cmd ..."
        apt install -y $cmd
    fi
done

log "INFO" "verify GPG signatures."
wget -O- $HASHICORP_APT_PUBKEY | gpg --dearmor | tee $KEYRING_PATH
gpg --no-default-keyring --keyring $KEYRING_PATH --fingerprint

log "INFO" "insert apt-release hashicorp reposiory"
echo "deb [signed-by=$KEYRING_PATH] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

log "INFO" "Install Hashicorp tools (terraform and packer CLIs)"
apt update && apt install -y terraform packer

log "INFO" "Check if terraform-cli is properly installed..."
if terraform version
then
    log "INFO" "terrform CLI installed successfully."
else
    log "ERROR" "terrform CLI not installed or configurated incorrectly, check installation steps. Aborting..."
    exit 1
fi

log "INFO" "Check if packer-cli is properly installed..."
if packer version
then
    log "INFO" "terrform CLI installed successfully."
else
    log "ERROR" "terrform CLI not installed or configurated incorrectly, check installation steps. Aborting..."
    exit 1
fi

log "INFO" "END 'install_hashicorp-tools.sh'"
