#!/usr/bin/env bash
source "../get_user_uid.sh"
SELECTED_UID=$?

DISABLE_TYPE=("soft" "hard")
SELECTED_TYPE=""
SELECTED_PKG=""

disableApp() {
    for SELECTED_PKG in $1; do
        adb shell pm disable --user "$SELECTED_UID" "$SELECTED_PKG"
    done
}

uninstallApp() {
    for SELECTED_PKG in $1; do
        adb shell pm uninstall --user "$SELECTED_UID" "$SELECTED_PKG"
    done
}

for SELECTED_TYPE in "${DISABLE_TYPE[@]}"; do
    file="$(cat "./$SELECTED_TYPE.txt")"
    if [ -z "$file" ]; then
        continue
    fi
    IFS=$'\n'
    if [ "$SELECTED_TYPE" = "${DISABLE_TYPE[0]}" ]; then
        disableApp "$file"
    else
        uninstallApp "$file"
    fi
done
