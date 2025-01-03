#!/bin/bash

. ./ressources/libraries/color.sh

FILES_DIR="./ressources/files"

askReboot() {
	yesnoanswer="null"
	while [[ ! ${yesnoanswer,,} =~ ^([yn]|yes|no)?$ ]]; do
		printf "${YELLOW}Would you like to reboot? [y/n] ${NS}"
		read -r yesnoanswer
	done
	case ${yesnoanswer,,} in
		y|yes) printf "${GREEN}Rebooting…${NS}"; sleep 3; sudo shutdown -r now;;
		n|no) exit 0;;
		*) printf "${RED}An error has occurred.${NS} Well, this is awkward… Would you please file a defect report?\n";;
	esac
}

checkRebootRequired() {
	printf "${BLUE}Should you reboot?${NS}\n"
	sudo needrestart
}

removeUnusedKernels() {
	printf "${BLUE}Removing unused kernels…${NS}\n"
	sudo apt remove linux-*v7 linux-*v7l linux-*v8 -y
	printf "${GREEN}Unused kernels were removed.${NS}\n"
}

upgradeSystem() {
	printf "${BLUE}Looking for system updates…${NS}\n"
	sudo apt update
	printf "${GREEN}Repositories were updated.${NS}\n"
	
	printf "${BLUE}Upgrading system…${NS}\n"
	sudo apt full-upgrade -y
	printf "${GREEN}System is now up-to-date.${NS}\n"

	printf "${BLUE}Removing packages that are not required anymore…${NS}\n"
	sudo apt autoremove -y
	printf "${GREEN}Packages that are not required anymore were removed.${NS}\n"

	printf "${BLUE}Cleaning cache…${NS}\n"
	sudo apt autoclean
	printf "${GREEN}Cache was cleaned.${NS}\n"
}

installBasicTools() {
	printf "${BLUE}Installing basic tools (needrestart)…${NS}\n"
	sudo apt install needrestart git mosh micro vim -y
	printf "${GREEN}Basic tools were installed.${NS}\n"
}

fixAptWarning() {
	printf "${BLUE}Fixing apt warning when updating repositories…${NS}\n"

	printf "${BLUE}Exporting key stored in trusted.gpg and storing it the right way…${NS}\n"
	sudo apt-key export 90FDDD2E | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/raspberrypi-debian-armhf.gpg
	printf "${GREEN}Key was exported and stored.${NS}\n"
		
	printf "${BLUE}Backing up .list files…${NS}\n"
	sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
	sudo mv /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak
	printf "${GREEN}.list files were backed up.${NS}\n"

	printf "${BLUE}Upgrading .list files…${NS}\n"
	sudo cp $FILES_DIR/sources.list /etc/apt
	sudo cp $FILES_DIR/raspi.list /etc/apt/sources.list.d
	printf "${GREEN}.list files were upgraded and apt warning is now gone.${NS}\n"
	
}
