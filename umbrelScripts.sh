#!/usr/bin/env bash

#Functions that was implemented to help the CLI of my Umbrel node:
UMBREL_ROOT="/home/${USER}/umbrel"
SCRIPTS="${UMBREL_ROOT}/scripts/"
# echo ">>> ${UMBREL_ROOT}"
# echo ">>> ${USER_FILE}"

__log_umbrel(){
	echo "\nUmbrel will $1 the app \"$2\" ...\n"
}

umbrelInstalledAppsList(){
	local USER_FILE="${UMBREL_ROOT}/db/user.json"
	
	cat "${USER_FILE}" | jq -r 'if has("installedApps") then .installedApps else [] end | join("\n")'
}

umbrelRestartApp() {
	__log_umbrel restart $1
	sudo {$SCRIPTS}restart $1
}

umbrelStopApp() {
	for i in $@
	do
		__log_umbrel stop $i
		sudo ${SCRIPTS}app stop $i; echo ""
	done
}

umbrelInit() {
	sudo "${SCRIPTS}start"
}

umbrelStop() {
	local confirm=""
	echo "\nDo You really want to stop all umbrel applications?\nContinue? (Y/N):"; read confirm

	if [[ "$confirm" = [yYsSeE] ]]; then
		echo "OK!!!!"
		# sudo "${SCRIPTS}stop"
	fi
}
