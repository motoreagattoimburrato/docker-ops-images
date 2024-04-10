#!/usr/bin/env bash
echo "[$(date --utc) - INFO]: START 'install_dependency-check.sh'"

DC_TMP_PATH=/opt/dependency-check.zip

while [ $# -gt 0 ]; do
    case "$1" in
        --url=*) DEPENDENCY_CHECK_URL="${1#*=}" ;;
        --asc-key=*) DEPENDENCY_CHECK_ASC="${1#*=}" ;;
        --pubkey=*) DEPENDENCY_CHECK_PUBKEY="${1#*=}" ;;
        --home=*) DEPENDENCY_CHECK_HOME="${1#*=}" ;;
        *) echo "[$(date --utc) - ERROR]: Invalid argument $1" ;;
    esac
    shift
done

# Abort if not super user
if [ "$(id -u)" -ne 0 ]; then
    echo "[$(date --utc) - ERROR]: You must have administrative privileges to run this script or must be run as root."
    echo "[$(date --utc) - ERROR]: Try 'sudo ./install_jdk.sh'"
    echo "[$(date --utc) - ERROR]: Aborting..."
    exit 1
fi

# Check if each required argument is set and provide specific error messages
if [ -z "$DEPENDENCY_CHECK_URL" ]; then
    echo "[$(date --utc) - ERROR]: --url argument is not defined or is empty. Aborting..."
    exit 1
fi

if [ -z "$DEPENDENCY_CHECK_ASC" ]; then
    echo "[$(date --utc) - ERROR]: --asc-key argument is not defined or is empty. Aborting..."
    exit 1
fi

if [ -z "$DEPENDENCY_CHECK_PUBKEY" ]; then
    echo "[$(date --utc) - ERROR]: --pubkey argument is not defined or is empty. Aborting..."
    exit 1
fi

if [ -z "$DEPENDENCY_CHECK_HOME" ]; then
    echo "[$(date --utc) - ERROR]: --home argument is not defined or is empty. Aborting..."
    exit 1
fi

echo "[$(date --utc) - INFO]: |---------------------------------------------------------------------------------------------------------|"
echo "[$(date --utc) - INFO]: | > INSTALLING DEPENDENCY-CHECK UNIX CLI                                                                  |"
echo "[$(date --utc) - INFO]: | > Official site: https://owasp.org/www-project-dependency-check/                                        |"
echo "[$(date --utc) - INFO]: | > CLI documentation: https://jeremylong.github.io/DependencyCheck/dependency-check-cli/index.html       |"
echo "[$(date --utc) - INFO]: | > Use cases: https://jeremylong.github.io/DependencyCheck/index.html                                    |"
echo "[$(date --utc) - INFO]: | > Source code: https://github.com/jeremylong/DependencyCheck                                            |"
echo "[$(date --utc) - INFO]: |---------------------------------------------------------------------------------------------------------|"

echo "[$(date --utc) - INFO]: installing requirements binaries - wget, unzip, gpg, openjdk-17-jdk - using APT"
apt install -y wget unzip gpg openjdk-17-jdk

echo "[$(date --utc) - INFO]: Now downloading $(basename $DEPENDENCY_CHECK_URL) ..."
wget -O $DC_TMP_PATH $DEPENDENCY_CHECK_URL
echo "[$(date --utc) - INFO]: Now downloading $(basename $$DEPENDENCY_CHECK_ASC) ..."
wget -O /tmp/dc.zip.asc $DEPENDENCY_CHECK_ASC

echo "[$(date --utc) - INFO]: verify ASC signatures."
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $DEPENDENCY_CHECK_PUBKEY
gpg --verify /tmp/dc.zip.asc $DC_TMP_PATH

echo "[$(date --utc) - INFO]: Installing dependency-check"
#unzip $DC_TMP_PATH -d $DEPENDENCY_CHECK_HOME
unzip $DC_TMP_PATH -d /tmp
mkdir -p $DEPENDENCY_CHECK_HOME
mv /tmp/dependency-check/* $DEPENDENCY_CHECK_HOME
rm -rf $DC_TMP_PATH /tmp/dc.zip.asc /tmp/dependency-check

echo "[$(date --utc) - INFO]: Check if dependency-check is properly installed..."
$DEPENDENCY_CHECK_HOME/bin/dependency-check.sh --version
if [[ $? -ne 0 ]]
then
    echo "[$(date --utc) - ERROR]: dependency-check not installed or configurated incorrectly, check installation steps. Aborting..."
    exit 1 
fi

echo "[$(date --utc) - INFO]: END 'install_dependency-check.sh'"
#exit 0