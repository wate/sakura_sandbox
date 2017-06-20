#!/bin/bash

# @todo 要テスト

SAKURACLOUD_ZONE=[tk1v|tk1a|is1a|is1b]
SAKURACLOUD_ACCESS_TOKEN=[YOUR_API_TOKEN]
SAKURACLOUD_ACCESS_TOKEN_SECRET=[YOUR_API_SECRET]

# 世代数
NUMBRE_OF_GENERATUINS=3

# 曜日＋時間指定での自動バックアップ(タグ名:backup_week_[mon|tue|wed|thu|fri|sat|sun]_[0-23])
WEEKLY_TAG=backup_week_`LANG=C date +%a_%k| tr "[:upper:]" "[:lower:]"|tr -d " "`
echo "Auto backup tag name: ${WEEKLY_TAG}"
for DISK_ID in `usacloud disk list --quiet --tags ${WEEKLY_TAG}`; do
  ARCHIVE_PREFIX=`usacloud disk read --format "{{.Name}}" ${DISK_ID}`
  ARCHIVE_SUFFIX=`date +"%Y%m%d_%H%M%S"`
  usacloud archive create --assumeyes --quiet --source-disk-id ${DISK_ID} --name "${ARCHIVE_PREFIX}_${ARCHIVE_SUFFIX}"
  for REMOVE_ARCHIVE_ID in `usacloud archive list --quiet --source-disk-id ${DISK_ID} --offset ${NUMBRE_OF_GENERATUINS}`; do
    usacloud archive delete --assumeyes --quiet ${REMOVE_ARCHIVE_ID}
  done;
done;

# 時間指定での自動バックアップ(タグ名:backup_hour_[0-23])
HOURLY_TAG=backup_hour_`date +%k|tr -d " "`
echo "Auto backup tag name: ${HOURLY_TAG}"
for DISK_ID in `usacloud disk list --quiet --tags ${HOURLY_TAG}`; do
  ARCHIVE_PREFIX=`usacloud disk read --format "{{.Name}}" ${DISK_ID}`
  ARCHIVE_SUFFIX=`date +"%Y%m%d_%H%M%S"`
  usacloud archive create --assumeyes --quiet --source-disk-id ${DISK_ID} --name "${ARCHIVE_PREFIX}_${ARCHIVE_SUFFIX}"
  for REMOVE_ARCHIVE_ID in `usacloud archive list --quiet --source-disk-id ${DISK_ID} --offset ${NUMBRE_OF_GENERATUINS}`; do
    usacloud archive delete --assumeyes --quiet ${REMOVE_ARCHIVE_ID}
  done;
done;
