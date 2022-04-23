#!/usr/bin/env bash
source "./get_user_uid.sh"

SELECTED_UID=$?
FILENAME="./pkgs_$SELECTED_UID.txt"
FILE_OWNER=""

is_sudo() {
    if [ "$(id -u)" -eq 0 ]; then
        FILE_OWNER="$SUDO_USER"
    else
        FILE_OWNER="$USER"
    fi
}

create_list() {
    adb shell pm list packages --user "$SELECTED_UID" | sed 's/package://g' >$FILENAME
    chown "$FILE_OWNER" $FILENAME
}

main() {
    is_sudo

    select=""

    if [ -s $FILENAME ]; then
        echo "List exist"
        read -rp "Overwite? [y/n]: " select
        while :; do
            case $select in
            y)
                create_list
                ;;
            n)
                break
                ;;
            *)
                read -rp "Overwite? [y/n]: " select
                continue
                ;;
            esac
            break
        done
    else
        create_list
    fi
}

main
