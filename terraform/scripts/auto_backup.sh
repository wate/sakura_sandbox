#!/bin/bash

SAKURACLOUD_ZONE=[tk1v/tk1a/is1a/is1b]
SAKURACLOUD_ACCESS_TOKEN=[YOUR_API_TOKEN]
SAKURACLOUD_ACCESS_TOKEN_SECRET=[YOUR_API_SECRET]

WEEKLY_TAG=backup_week_`LANG=C date +%a| tr "[:upper:]" "[:lower:]"`
HOURLY_TAG=backup_hour_`date +%k|tr -d " "`
for DISK_ID in `usacloud disk list --quiet --tags ${HOURLY_TAG}`; do
	ARCHIVE_PREFIX=`usacloud disk read --format "{{.Name}}" ${DISK_ID}`
	ARCHIVE_SUFFIX=`date +"%Y%m%d_%H%M%S"`
	usacloud archive create --assumeyes --source-disk-id ${DISK_ID} --name "${ARCHIVE_PREFIX}_${ARCHIVE_SUFFIX}"
done;
