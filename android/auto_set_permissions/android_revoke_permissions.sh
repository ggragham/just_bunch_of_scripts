#!/usr/bin/env bash
source "../get_user_uid.sh"
SELECTED_UID=$?

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
RED='\033[0;31m'
NC='\033[0m'

CAMERA_PERMISSION=("android.permission.CAMERA")
CONTACT_PERMISSION=("android.permission.WRITE_CONTACTS" "android.permission.READ_CONTACTS" "android.permission.GET_ACCOUNTS")
STORAGE_PERMISSION=("android.permission.WRITE_EXTERNAL_STORAGE" "android.permission.READ_EXTERNAL_STORAGE")
MICROPHONE_PERMISSION=("android.permission.RECORD_AUDIO")
PHONE_PERMISSION=("android.permission.READ_PHONE_STATE" "android.permission.CALL_PHONE")
LOCATION_PERMISSION=("android.permission.ACCESS_COARSE_LOCATION" "android.permission.ACCESS_FINE_LOCATION")
NEARBY_DEVICE_PERMISSION=("android.permission.BLUETOOTH_CONNECT" "android.permission.BLUETOOTH_SCAN" "android.permission.BLUETOOTH_ADVERTISE")
GROUP_LIST=("CAMERA_PERMISSION" "CONTACT_PERMISSION" "STORAGE_PERMISSION" "MICROPHONE_PERMISSION" "PHONE_PERMISSION" "LOCATION_PERMISSION" "NEARBY_DEVICE_PERMISSION")

PERMISSION_LIST=""
SELECTED_GROUP=""
SELECTED_PERMISSION=""
SELECTED_PKG=""

FILE_OWNER=""
ERROR_LOG_FILE="./error_log.txt"

is_sudo() {
    if [ "$(id -u)" -eq 0 ]; then
        FILE_OWNER="$SUDO_USER"
    else
        FILE_OWNER="$USER"
    fi
}

chown "$FILE_OWNER" "$ERROR_LOG_FILE"

revokePermissions() {
    adb shell pm revoke --user "$SELECTED_UID" "$1" "$2" 2>> "$ERROR_LOG_FILE"
    if [ "$?" -eq 0 ]; then
        echo -e "Permission $2 for $1 has been revoked"
    else 
        echo -e "Permission $2 for $1 ${RED}${BOLD}is not revoked${NORMAL}${NC}"
    fi
}

is_sudo

for SELECTED_GROUP in "${GROUP_LIST[@]}"; do
    currentFile="$SELECTED_GROUP.txt"
    if [ -s "$currentFile" ]; then
    #    echo -e "$SELECTED_GROUP: "
       declare -a "$SELECTED_GROUP"
       declare -n PERMISSION_LIST="$SELECTED_GROUP"
       for SELECTED_PERMISSION in "${PERMISSION_LIST[@]}"; do
            # echo -e "\t$SELECTED_PERMISSION: "
            file="$(cat "./$currentFile")"
            IFS=$'\n'
            for SELECTED_PKG in $file; do
                # echo -e "\t\t$SELECTED_PKG"
                revokePermissions "$SELECTED_PKG" "$SELECTED_PERMISSION"
            done
       done
    fi
done
