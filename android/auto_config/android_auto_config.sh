#!/usr/bin/env bash

SETTING_NAMESPACE=("secure" "system" "global")
SELECTED_SETTING_NAMESPACE=""
SELECTED_LINE=""
SETTING_STRING=""
SETTING_VALUE=""

getSettingString() {
    SETTING_STRING="$(echo -e "$SELECTED_LINE" | awk '{print $1}')"
    SETTING_VALUE="$(echo -e "$SELECTED_LINE" | awk '{print $2}')"
}

setSetting() {
    adb shell settings put "$SELECTED_SETTING_NAMESPACE" "$SETTING_STRING" "$SETTING_VALUE"
}

getSetting() {
    adb shell settings get "$SELECTED_SETTING_NAMESPACE" "$SETTING_STRING"
}

for SELECTED_SETTING_NAMESPACE in "${SETTING_NAMESPACE[@]}"; do
    file="$(cat "./$SELECTED_SETTING_NAMESPACE.txt")"
    IFS=$'\n'
    for SELECTED_LINE in $file; do
        getSettingString
        setSetting
        echo -e "$SELECTED_SETTING_NAMESPACE" "$SETTING_STRING" "$(getSetting)"
    done
done
