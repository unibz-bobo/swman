#!/bin/bash

# Sets the variable ID_LIKE containing the most generic
# distribution name.
# Example: ID_LIKE=arch, or ID_LIKE=debian
detectLinuxDistribution() {
  eval `cat /etc/*-release | grep ID_LIKE`
}

# DO NOT CHANGE! This is needed to detect the distribution name.
detectLinuxDistribution

# Arch Linux ARM only. Upgrade to pacbobo if it is present in the system.
detectPacbobo() {
  which pacbobo > /dev/null 2>&1
  if [ $? = 0 ]; then
    pacman=pacbobo
  else
    pacman=pacman
  fi
}

# DO NOT CHANGE! This is needed to detect the pacbobo package manager.
detectPacbobo


# Query if a package is already installed.
packageQuery() {
  local packageName=$1
  if [ $ID_LIKE = arch ]; then
    $pacman -Qi $packageName > /dev/null
    return $?
  fi
  if [ $ID_LIKE = debian ]; then
    dpkg-query -l $packageName | grep "^ii" > /dev/null
    return $?
  fi
  return 0
}

# Update package databases and upgrade system.
packageUpdate() {
  if [ $ID_LIKE = arch ]; then
    $pacman --noconfirm -Syu
  fi
  if [ $ID_LIKE = debian ]; then
    apt-get update
    apt-get --yes --force-yes upgrade
  fi
}

packageInstall() {
  local packageName=$1
  if [ $ID_LIKE = arch ]; then
    $pacman --noconfirm -S $packageName
    return $?
  fi
  if [ $ID_LIKE = debian ]; then
    apt-get --yes --force-yes -q=2 install $packageName
    return $?
  fi
}

packageUninstall() {
  local packageName=$1
  if [ $ID_LIKE = arch ]; then
    $pacman --noconfirm -R $packageName
    return $?
  fi
  if [ $ID_LIKE = debian ]; then
    apt-get --yes --force-yes -q=2 --purge autoremove $packageName
    return $?
  fi
}
