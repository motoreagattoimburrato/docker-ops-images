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

log "INFO" "START 'install_dependency-check.sh'"

DC_TMP_PATH=/opt/dependency-check.zip

while [ $# -gt 0 ]; do
    case "$1" in
        --url=*) DEPENDENCY_CHECK_URL="${1#*=}" ;;
        --asc-key=*) DEPENDENCY_CHECK_ASC="${1#*=}" ;;
        --pubkey=*) DEPENDENCY_CHECK_PUBKEY="${1#*=}" ;;
        --home=*) DEPENDENCY_CHECK_HOME="${1#*=}" ;;
        --help)
            echo "Usage: ./install_dependency-check.sh --url=[URL] --asc-key=[ASC_KEY_URL] --pubkey=[PUBKEY] --home=[INSTALL_DIRECTORY]"
            echo "Required arguments:"
            echo "  --url        URL to the Dependency-Check ZIP file."
            echo "  --asc-key    URL to the ASC signature file for verifying the download."
            echo "  --pubkey     Public key ID or URL for GPG to verify the ASC signature."
            echo "  --home       The directory where Dependency-Check will be installed."
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
    log "ERROR" "Try 'sudo ./install_dependency-check.sh'..."
    log "ERROR" "Aborting..."
    exit 1
fi

if [ -z "$DEPENDENCY_CHECK_URL" ]; then
    log "ERROR" "--url argument is not defined or is empty. Aborting..."
    exit 1
fi

if [ -z "$DEPENDENCY_CHECK_ASC" ]; then
    log "ERROR" "--asc-key argument is not defined or is empty. Aborting..."
    exit 1
fi

if [ -z "$DEPENDENCY_CHECK_PUBKEY" ]; then
    log "ERROR" "--pubkey argument is not defined or is empty. Aborting..."
    exit 1
fi

if [ -z "$DEPENDENCY_CHECK_HOME" ]; then
    log "ERROR" "--home argument is not defined or is empty. Aborting..."
    exit 1
fi

log "INFO" "|---------------------------------------------------------------------------------------------------------|"
log "INFO" "| > INSTALLING DEPENDENCY-CHECK UNIX CLI                                                                  |"
log "INFO" "| > Official site: https://owasp.org/www-project-dependency-check/                                        |"
log "INFO" "| > CLI documentation: https://jeremylong.github.io/DependencyCheck/dependency-check-cli/index.html       |"
log "INFO" "| > Use cases: https://jeremylong.github.io/DependencyCheck/index.html                                    |"
log "INFO" "| > Source code: https://github.com/jeremylong/DependencyCheck                                            |"
log "INFO" "|---------------------------------------------------------------------------------------------------------|"

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

download_file "$DEPENDENCY_CHECK_URL" "$DC_TMP_PATH"

download_file "$DEPENDENCY_CHECK_ASC" "/tmp/dc.zip.asc"

log "INFO" "verify ASC signatures."
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $DEPENDENCY_CHECK_PUBKEY
gpg --verify /tmp/dc.zip.asc $DC_TMP_PATH

log "INFO" "Installing dependency-check"
#unzip $DC_TMP_PATH -d $DEPENDENCY_CHECK_HOME
unzip $DC_TMP_PATH -d /tmp
mkdir -p $DEPENDENCY_CHECK_HOME
mv /tmp/dependency-check/* $DEPENDENCY_CHECK_HOME
trap "rm -rf $DC_TMP_PATH /tmp/dc.zip.asc /tmp/dependency-check" EXIT
#rm -rf $DC_TMP_PATH /tmp/dc.zip.asc /tmp/dependency-check

log "INFO" "Check if dependency-check is properly installed..."
if $DEPENDENCY_CHECK_HOME/bin/dependency-check.sh --version
then
    log "INFO" "Dependency-Check installed successfully."
    log "INFO" "To make Dependency-Check available from any terminal session, add it to your PATH:"
    log "INFO" "Add the following line to your .bashrc, .zshrc, or other shell configuration file:"
    echo "export PATH=\"\$PATH:$DEPENDENCY_CHECK_HOME/bin\""
    log "INFO" "Alternatively, you can run the following command:"
    echo "echo 'export PATH=\"\$PATH:$DEPENDENCY_CHECK_HOME/bin\"' >> ~/.bashrc && source ~/.bashrc"
else
    log "ERROR" "dependency-check not installed or configurated incorrectly, check installation steps. Aborting..."
    exit 1
fi

log "INFO" "END 'install_dependency-check.sh'"
#exit 0