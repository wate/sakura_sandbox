#!/bin/bash
#
# @sacloud-name startupscript_name
# @sacloud-once
# @sacloud-desc-begin
# ここから -->
# スタートアップスクリプトの説明をここに各
# <-- ここまで
# @sacloud-desc-end
# @sacloud-require-archive distro-centos distro-ver-7
#
# @sacloud-apikey required permission=create AK "APIキー"
#
# @see https://manual.sakura.ad.jp/cloud/startup-script/about.html

#===== Startup Script Motd Monitor =====#
_motd() {
	LOG=$(ls /root/.sacloud-api/notes/*log)
	case $1 in
		start)
			echo -e "\n#-- Startup-script is \\033[0;32mrunning\\033[0;39m. --#\n\nPlease check the log file: ${LOG}\n" > /etc/motd
		;;
		fail)
			echo -e "\n#-- Startup-script \\033[0;31mfailed\\033[0;39m. --#\n\nPlease check the log file: ${LOG}\n" > /etc/motd
			exit 1
		;;
		end)
			cp -f /dev/null /etc/motd
		;;
	esac
}

yum install -y yum-utils bash-completion
yum-config-manager --enable epel
yum install -y jq

# usacloud install
curl -fsSL http://releases.usacloud.jp/usacloud/repos/setup-yum.sh | sh
# get zone name
SACLOUD_ZONE=$(jq -r ".Zone.Name" /root/.sacloud-api/server.json)

# setup usacloud
usacloud config --token ${SACLOUD_APIKEY_ACCESS_TOKEN}
usacloud config --secret ${SACLOUD_APIKEY_ACCESS_TOKEN_SECRET}
usacloud config --zone ${SACLOUD_ZONE}

yum install -y dehydrated



exit 0
