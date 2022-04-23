#!/usr/bin/env bash
source "../get_user_uid.sh"

SELECTED_UID=$?
FILE="$(cat "../pkgs_$SELECTED_UID.txt")"
SELECTED_PKG=""

killApp() {
    adb shell am force-stop --user all "$1"
}

clearData() {
    adb shell pm clear --user "$SELECTED_UID" "$1"
}

IFS=$'\n'
for SELECTED_PKG in $FILE; do
    # If clear this net.typeblog.shelter, workprofile will be broken
    if [ "$SELECTED_PKG" = "net.typeblog.shelter" ]; then
        continue
    fi
    
    killApp "$SELECTED_PKG"
    echo -e "$SELECTED_PKG killed"
    clearData "$SELECTED_PKG"
done
