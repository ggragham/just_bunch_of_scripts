#!/usr/bin/env bash

# SELECTED_USER=""
SELECTED_UID=""
selectUserNumber=""

list_users() {
	adb shell pm list users
}

list_user_name() {
	list_users | awk -F '[::]' '(NR>1){print $2}'
}

list_user_uid() {
	list_users | awk -F '[{:]' '(NR>1){print $2}'
}

select_user() {
	LINE_COUNT=$(list_user_name | wc -l)

	if [[ $LINE_COUNT -eq 1 ]]; then
		selectUserNumber=1
	else
		echo -e "Users: "
		list_user_name | sed '=' | sed 'N;s/\n/\) /'

		while :; do
			if [[ $selectUserNumber -gt $LINE_COUNT ]] || [[ $selectUserNumber -le 0 ]]; then
				read -rp "Select user: " selectUserNumber
				continue
			fi
			# SELECTED_USER=$(list_user_name | awk -v number="$selectUserNumber" 'NR==number{print $0}')
			break
		done
	fi
}

select_uid() {
	SELECTED_UID=$(list_user_uid | awk -v number="$selectUserNumber" 'NR==number{print $0}')
}

get_uid() {
	select_user
	select_uid
	return "$SELECTED_UID"
}

get_uid
