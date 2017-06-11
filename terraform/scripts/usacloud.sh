#!/bin/bash

# @sacloud-once

# @sacloud-desc  usacloudをインストールします。
# @sacloud-require-archive distro-centos
# @sacloud-require-archive distro-ubuntu
# @sacloud-require-archive distro-debian

INSTALL_SCRIPT_PREFIX="https://usacloud.b.sakurastorage.jp/repos/"
if [ -e /etc/redhat-release ]; then
  INSTALL_SCRIPT_URL=${INSTALL_SCRIPT_PREFIX}"setup-yum.sh"
  if ! command -v curl >/dev/null 2>&1; then
    yum install -y curl
  fi
else
  INSTALL_SCRIPT_URL=${INSTALL_SCRIPT_PREFIX}"setup-apt.sh"
  if ! command -v curl >/dev/null 2>&1; then
    apt-get install -y curl
  fi
fi

curl -fsSL "${INSTALL_SCRIPT_URL}" | sh
