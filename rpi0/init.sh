#!/bin/bash

. ./ressources/libraries/util.sh

removeUnusedKernels
upgradeSystem
installBasicTools
fixAptWarning
checkRebootRequired
askReboot
