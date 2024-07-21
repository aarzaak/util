#!/bin/bash

. ./ressources/libraries/color.sh

FILES_DIR="../files"

askReboot() {
	yesnoanswer="null"
	while [[ ! ${yesnoanswer,,} =~ ^([yn]|yes|no)?$ ]]; do
		read -r -p "${BLUE}Would you like to reboot? [y/n] " yesnoanswer
	done
	case ${yesnoanswer,,} in
		y|yes) printf "${GREEN}Rebooting…"; sleep 3; sudo shutdown -r now;;
		n|no) exit 0;;
		*) printf "${RED}An error has occurred.${NS} Well, this is awkward… Would you please file a defect report?\n";;
	esac
}

checkRebootRequired() {
	printf "${BLUE}Should you reboot?\n"
	sudo needrestart
}

removeUnusedKernels() {
	printf "${BLUE}Removing unused kernels…\n"
	sudo apt remove linux-*v7 linux-*v7l linux-*v8 -y
	printf "${GREEN}Unused kernels were removed.\n"
}

upgradeSystem() {
	printf "${BLUE}Looking for system updates…\n"
	sudo apt update
	printf "${GREEN}Repositories were updated.\n"
	
	printf "${BLUE}Upgrading system…\n"
	sudo apt full-upgrade -y
	printf "${GREEN}System is now up-to-date.\n"
}

installBasicTools() {
	printf "${BLUE}Installing basic tools (needrestart)…\n"
	sudo apt install needrestart -y
	printf "${GREEN}Basic tools were installed.\n"
}

fixAptWarning() {
	printf "${BLUE}Fixing apt warning when updating repositories…\n"

	printf "${BLUE}Exporting key stored in trusted.gpg and storing it the right way…\n"
	sudo apt-key export 90FDDD2E | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/raspberrypi-debian-armhf.gpg
	printf "${GREEN}Key was exported and stored.\n"
		
	printf "${BLUE}Backing up .list files…\n"
	sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
	sudo mv /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak
	printf "${GREEN}.list files were backed up.\n"

	printf "${BLUE}Upgrading .list files…\n"
	sudo cp $FILES_DIR/sources.list /etc/apt
	sudo cp $FILES_DIR/raspi.list /etc/apt/sources.list.d
	printf "${GREEN}.list files were upgraded and apt warning is now gone.\n"
	
}
