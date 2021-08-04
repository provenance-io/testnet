#!/bin/bash

CHAIN_ID=''
MONIKER=''
PROVENANCED_VERSION=''

SYSTEMD_FILE='[Unit]
Description=provenanced
Requires=network-online.target
After=network-online.target

[Service]
Restart=on-failure
User=provenanced
Group=provenanced
PermissionsStartOnly=true
ExecStart=/home/provenanced/go/bin/cosmovisor start -t --home /provenanced/
Environment="PATH=/home/provenanced/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin"
Environment="DAEMON_NAME=provenanced"
Environment="DAEMON_HOME=/provenanced"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=true"
ExecReload=/bin/kill -HUP $MAINPID
KillSignal=SIGTERM

[Install]
WantedBy=multi-user.target'

function check_err () {
  if [[ $1 -ne 0 ]]; then
    echo -e "\033[0;31m ✕\033[0m"
    echo -e "\033[0;31m$2\033[0m"
    exit 1
  else
    echo -e "\033[0;32m ✓\033[0m"
  fi
}

function append_ifnoe () {
  su $3 -c "grep -qxF \"$1\" $2" || echo \"$1\" | su $3 -c "tee -a $2"
}

printf "Checking current user... "
if [[ "${EUID}" -ne 0 ]]; then
  check_err 1 "user should be root"
else
  check_err 0 ""
fi 

printf "Installing pre-requisite libraries... "
err=$(apt-get update && apt-get install -y jq unzip libuser libleveldb-dev git curl systemd)
check_err $? "${err}"

printf "Deleting existing go install... "
err=$(rm -rf /usr/local/go 2>&1 > /dev/null)
check_err $? "${err}"

printf "Downloading go... "
err=$(curl -L -s https://golang.org/dl/go1.15.8.linux-amd64.tar.gz -o /tmp/go1.15.8.linux-amd64.tar.gz 2>&1 > /dev/null)
check_err $? "${err}"

printf "Unpacking go... "
err=$(tar -xf /tmp/go1.15.8.linux-amd64.tar.gz -C /usr/local/ 2>&1 > /dev/null)
check_err $? "${err}"

printf "Creating provenanced group... "
err=$(id -g provenanced 2>&1 > /dev/null || lgroupadd provenanced)
check_err $? "${err}"

printf "Creating provenanced service user... "
err=$(id -u provenanced 2>&1 > /dev/null || luseradd provenanced -g provenanced -d /home/provenanced -s /bin/bash)
check_err $? "${err}"

printf "Updating provenanced user profile... "
for line in 'GOPATH="$HOME/go"' 'PATH="$GOPATH/bin:$PATH"' 'PIO_HOME="/provenanced/"'; do
  err=$(append_ifnoe ${line} /home/provenanced/.profile provenanced 2>&1 > /dev/null)
  if [[ $? -ne 0 ]]; then
    check_err 1 "${err}"
  fi
done
check_err 0 ""

printf "Downloading cosmovisor... "
err=$(su provenanced -c "/usr/local/go/bin/go get github.com/provenance-io/cosmovisor/cmd/cosmovisor 2>&1 > /dev/null")
check_err $? "${err}"

printf "Fetching provenance release url... "
binary_url=$(curl -L -s https://api.github.com/repos/provenance-io/provenance/releases/tags/${PROVENANCED_VERSION}  | jq -r ".assets[]|select(.name==\"provenance-linux-amd64-${PROVENANCED_VERSION}.zip\")|.browser_download_url")
check_err $?

printf "Downloading provenance release... "
err=$(curl -L -s ${binary_url} -o /tmp/provenance.zip 2>&1 > /dev/null)
check_err $? "${err}"

printf "Creating provenanced directory... "
err=$(mkdir -p /provenanced 2>&1 > /dev/null)
check_err $? "${err}"

printf "Chowning provenanced directory... "
err=$(chown provenanced:provenanced /provenanced)
check_err $? "${err}"

printf "Unpacking release zip... "
err=$(su provenanced -c "unzip -u /tmp/provenance.zip -d /tmp 2>&1 > /dev/null")
check_err $? "${err}"

printf "Copying shared object files to /usr/lib/x86_64-linux-gnu... "
err=$(mv /tmp/bin/libwasmvm.so /usr/lib/x86_64-linux-gnu/libwasmvm.so 2>&1 > /dev/null)
check_err $? "${err}"

printf "Creating symlink to libwasmvm.so... "
err=$(ln -sf /usr/lib/x86_64-linux-gnu/libwasmvm.so /usr/lib/x86_64-linux-gnu/libwasmvm.so.1d 2>&1 > /dev/null)
check_err $? "${err}"

printf "Creating symlink to libleveldb.so... "
err=$(ln -sf /usr/lib/x86_64-linux-gnu/libleveldb.so /usr/lib/x86_64-linux-gnu/libleveldb.so.1 2>&1 > /dev/null)
check_err $? "${err}"

printf "Creating genesis directory for cosmovisor... "
err=$(su provenanced -c "mkdir -p -m 755 /provenanced/cosmovisor/genesis/bin 2>&1 > /dev/null")
check_err $? "${err}"

printf "Creating symlink for current bin... "
err=$(ln -sf /provenanced/cosmovisor/genesis/bin /provenanced/cosmovisor/genesis/current 2>&1 > /dev/null)
check_err $? "${err}"

printf "Creating update directory for cosmovisor... "
err=$(mkdir -p -m 755 /provenanced/cosmovisor/upgrades 2>&1 > /dev/null)
check_err $? "${err}"

printf "Moving provenanced daemon to cosmovisor genesis... "
err=$(mv /tmp/bin/provenanced /provenanced/cosmovisor/genesis/bin/provenanced 2>&1 > /dev/null)
check_err $? "${err}"

printf "Creating symlink to provenanced daemon... "
err=$(ln -sf /provenanced/cosmovisor/genesis/bin/provenanced /usr/local/bin/provenanced 2>&1 > /dev/null)
check_err $? "${err}"

printf "Backing up current genesis file (if exists)... "
if sudo bash -c '[[ -f /provenanced/config/genesis.json ]]'; then
 err=$(su provenanced -c "mv /provenanced/config/genesis.json /provenanced/config/genesis.json.bak")
 check_err $? "${err}"
else
  check_err 0 ""
fi

printf "Resetting provenanced... "
err=$(su provenanced -c "provenanced -t --home /provenanced/ unsafe-reset-all")
check_err $? "${err}"

printf "Initializing tendermint... "
err=$(su provenanced -c "/usr/local/bin/provenanced -t init --chain-id=${CHAIN_ID} ${MONIKER} --home /provenanced")
check_err $? "${err}"

printf "Pulling genesis file from ${CHAIN_ID}... "
err=$(curl -L -s -H 'Accept: application/vnd.github.v3.raw' https://api.github.com/repos/provenance-io/testnet/contents/${CHAIN_ID}/genesis.json | su provenanced -c "tee /provenanced/config/genesis.json")
check_err $? "${err}"

printf "Pulling config.toml file from ${CHAIN_ID}... "
err=$(curl -L -s -H 'Accept: application/vnd.github.v3.raw' https://api.github.com/repos/provenance-io/testnet/contents/${CHAIN_ID}/config.toml | su provenanced -c "tee /provenanced/config/config.toml")
check_err $? "${err}"

printf "Creating provenanced systemd service... "
err=$(echo "${SYSTEMD_FILE}" | tee /etc/systemd/system/provenanced.service)
check_err $? "${err}"

printf "Reloading daemon units... "
err=$(systemctl daemon-reload 2>&1 > /dev/null)
check_err $? "${err}"

echo 'Install complete! Run "systemctl start provenanced" to start the service.'