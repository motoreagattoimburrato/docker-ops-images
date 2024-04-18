#!/usr/bin/env bash
set -e

# Setup error handling and cleanup
trap 'echo "An error occurred. Exiting..."; exit 1' ERR
#trap 'rm -rf /tmp/*' EXIT

log() {
    echo "[$(date --utc) - $1]: $2"
}

download_file() {
    local url=$1
    local output_path=$2

    log "INFO" "Now downloading $(basename $url) ..."
    curl -L --retry 5 --retry-delay 5 --output $output_path $url || {
        log "ERROR" "Failed to download $(basename $url). Aborting..."
        exit 1
    }
}

log "INFO" "START 'install_sonar-scanner.sh'"

SS_TMP_PATH=/opt/sonar-scanner.zip

while [ $# -gt 0 ]; do
    case "$1" in
        --url=*) SONAR_SCANNER_URL="${1#*=}" ;;
        --asc-key=*) SONAR_SCANNER_ASC="${1#*=}" ;;
        --pubkey=*) SONAR_SCANNER_PUBKEY="${1#*=}" ;;
        --home=*) SONAR_SCANNER_HOME="${1#*=}" ;;
        --help)
            echo "Usage: ./install_sonar-scanner.sh --url=[URL] --asc-key=[ASC_KEY_URL] --pubkey=[PUBKEY] --home=[INSTALL_DIRECTORY]"
            echo "Required arguments:"
            echo "  --url        URL to the SonarQube Scanner ZIP file."
            echo "  --asc-key    URL to the ASC signature file for verifying the download."
            echo "  --pubkey     URL to the Public key ID or URL for GPG to verify the ASC signature."
            echo "  --home       The directory where SonarQube Scanner will be installed."
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
    log "ERROR" "Try 'sudo ./install_sonar-scanner.sh'..."
    log "ERROR" "Aborting..."
    exit 1
fi

if [ -z "$SONAR_SCANNER_URL" ]; then
    log "ERROR" "--url argument is not defined or is empty. Aborting..."
    exit 1
fi

if [ -z "$SONAR_SCANNER_ASC" ]; then
    log "ERROR" "--asc-key argument is not defined or is empty. Aborting..."
    exit 1
fi

if [ -z "$SONAR_SCANNER_PUBKEY" ]; then
    log "ERROR" "--pubkey argument is not defined or is empty. Aborting..."
    exit 1
fi

if [ -z "$SONAR_SCANNER_HOME" ]; then
    log "ERROR" "--home argument is not defined or is empty. Aborting..."
    exit 1
fi

log "INFO" "|-----------------------------------------------------------------------------------------------------------------|"
log "INFO" "| > INSTALLING SONAR-SCANNER UNIX CLI                                                                             |"
log "INFO" "| > Official site: https://docs.sonarsource.com/sonarqube/latest/                                                 |"
log "INFO" "| > CLI documentation: https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/scanners/sonarscanner/ |"
log "INFO" "|-----------------------------------------------------------------------------------------------------------------|"

log "INFO" "Check if requirements binaries are present and installed if not - wget, unzip, gpg, openjdk-17-jdk - using APT"
for cmd in curl unzip gpg openjdk-17-jdk; do
    if command -v $cmd &> /dev/null; then
        log "WARN" "$cmd is already installed, skip installation..."
    else
        log "INFO" "Now installing $cmd ..."
        apt install -y $cmd
    fi
done

#apt install -y wget unzip gpg openjdk-17-jdk

download_file "$SONAR_SCANNER_URL" "$SS_TMP_PATH"

download_file "$SONAR_SCANNER_ASC" "/tmp/ss.zip.asc"

download_file "$SONAR_SCANNER_PUBKEY" "/tmp/sonarsource-public.key"

log "INFO" "verify ASC signatures."
gpg --import /tmp/sonarsource-public.key
gpg --verify /tmp/ss.zip.asc $SS_TMP_PATH

log "INFO" "Installing sonar-scanner"
#unzip $SS_TMP_PATH -d $SONAR_SCANNER_HOME
unzip $SS_TMP_PATH -d /tmp
mkdir -p $SONAR_SCANNER_HOME
mv /tmp/sonar-scanner-*-linux/* $SONAR_SCANNER_HOME
trap "rm -rf $SS_TMP_PATH /tmp/ss.zip.asc /tmp/sonar-scanner /tmp/sonarsource-public.key" EXIT
#rm -rf $SS_TMP_PATH /tmp/ss.zip.asc /tmp/sonar-scanner /tmp/sonarsource-public.key

log "INFO" "Check if sonar-scanner is properly installed..."
if $SONAR_SCANNER_HOME/bin/sonar-scanner --version
then
    log "INFO" "Sonar-Scanner installed successfully."
    log "INFO" "To make Sonar-Scanner available from any terminal session, add it to your PATH:"
    log "INFO" "Add the following line to your .bashrc, .zshrc, or other shell configuration file:"
    echo "export PATH=\"\$PATH:${SONAR_SCANNER_HOME}/bin\""
    log "INFO" "Alternatively, you can run the following command:"
    echo "echo 'export PATH=\"\$PATH:${SONAR_SCANNER_HOME}/bin\"' >> ~/.bashrc && source ~/.bashrc"
    log "INFO" "Check SONAR_USER_HOME in Env System Variables, default should be: ${HOME}/.sonar"
else
    log "ERROR" "sonar-scanner not installed or configurated incorrectly, check installation steps. Aborting..."
    exit 1
fi

log "INFO" "END 'install_sonar-scanner.sh'"
#exit 0