#!/usr/bin/env bash
# **** License ****
#
# Copyright (C) 2017 by Helmrock Consulting
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# **** End License ****
#
# Author: Neil Beadle
# Adds RFC2136 DDNS templates to the EdgeOS based Edge Routers

ME="${0##*/} ${VERSION}: "

# Uncomment for debugging or syntax checking
# Syntax check - uncomment for non execution dry run:
# set -n
# source ./bash_debug_function.sh
# s_dbg on verbose
# DEBUG=Yes

# Make sure script is run as admin
if [[ ${EUID} -eq 0 ]]; then
	echo 'This script must be run as the EdgeOS admin user, not root!'
	exit 1
fi

# Set up the EdgeOS environment
source /opt/vyatta/etc/functions/script-template
OPRUN=/opt/vyatta/bin/vyatta-op-cmd-wrapper
CFGRUN=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper
API=/bin/cli-shell-api
shopt -s expand_aliases

alias begin='${CFGRUN} begin'
alias cleanup='${CFGRUN} cleanup'
alias comment='${CFGRUN} comment'
alias commit='${CFGRUN} commit'
alias copy='${CFGRUN} copy'
alias delete='${CFGRUN} delete'
alias discard='${CFGRUN} discard'
alias end='${CFGRUN} end'
alias load='${CFGRUN} load'
alias rename='${CFGRUN} rename'
alias save='${CFGRUN} save'
alias set='${CFGRUN} set'
alias show='${API} showConfig'
alias version='${OPRUN} show version'

alias bold='tput bold'
alias normal='tput sgr0'
alias reverse='tput smso'
alias underline='tput smul'

alias black='tput setaf 0'
alias blink='tput blink'
alias blue='tput setaf 4'
alias cyan='tput setaf 6'
alias green='tput setaf 2'
alias lime='tput setaf 190'
alias magenta='tput setaf 5'
alias powder='tput setaf 153'
alias purple='tput setaf 171'
alias red='tput setaf 1'
alias tan='tput setaf 3'
alias white='tput setaf 7'
alias yellow='tput setaf 3'
alias ansi='sed -r "s/\[(.[^]]*)\]/\[$(cyan)\1$(normal)\]/g"'

# Setup the echo_logger function
echo_logger ()
{
local MSG=
SHOWVER=$(version | sed 's/$/;/g')
BUILD=$(echo ${SHOWVER} | awk 'BEGIN {RS=";"} /Build ID:/ {print $3}')

  shopt -s checkwinsize
  COLUMNS=$(tput cols)

  case "${1}" in
    E)
      shift
      MSG="[$(red)$(bold)ERROR$(normal)]: ${@}"
      LOG="[ERROR]: ${@}";;
    F)
      shift
      MSG="[$(red)$(bold)FAILED$(normal)]: ${@}"
      LOG="[FAILED]: ${@}";;
    FE)
      shift
      MSG="[$(red)$(bold)FATAL ERROR$(normal)]: ${@}"
      LOG="[FAILED]: ${@}";;
    I)
      shift
      MSG="[$(blue)$(bold)INFO$(normal)]: ${@}"
      LOG="[INFO]: ${@}";;
    S)
      shift
      MSG="[$(green)$(bold)SUCCESS$(normal)]: ${@}"
      LOG="[SUCCESS]: ${@}";;
    T)
      shift
      MSG="[$(tan)$(bold)TRYING$(normal)]: ${@}"
      LOG="[TRYING]: ${@}";;
    W)
      shift
      MSG="[$(yellow)$(bold)WARNING$(normal)]: ${@}"
      LOG="[WARNING]: ${@}";;
    *)
      echo "ERROR: usage: echo_logger MSG TYPE(E, F, FE, I, S, T, W) MSG."
      exit 1;;
  esac

  echo "$(echo ${MSG} | ansi)" | fold -s -w ${COLUMNS}
  logger -t ${ME} "${LOG}"
}

# Function to output command status of success or failure to screen and log
try ()
{
  [[ ${DEBUG} ]] && echo_logger T "[${@}]..."
  if eval ${@}
  then
    echo_logger                 S "[${@}]."
    return 0
  else
    echo_logger                 E "[${@}] unsuccessful!"
    return 1
  fi
}

# Usage: yesno prompt...
yesno ()
{
  default=

  if [[ "${1}" = "-y" ]]
  then
    default='y'
    shift
  elif [[ "${1}" = "-n" ]]
  then
    default='n'
    shift
  fi

  if [[ ${#} = 0 ]]
  then
    prompt="[Y/n]: "
  else
    prompt="${@}"
  fi

  while true
  do
    read -p "${prompt}" || exit 1
    if [[ -z "${REPLY}" && ! -z "${default}" ]]
    then
      REPLY=$default
    fi
    case "${REPLY}" in
      y*|Y*)  return 0;;
      n*|N*)  return 1;;
          *)  echo "Answer (y)es or (n)o please";;
    esac
  done
}

Delete_RFC2136 ()
{
local rfc2136_tmpl="/opt/vyatta/share/vyatta-cfg/templates/service/dns/dynamic/interface/node.tag/rfc2136/"
local post_cfg="/config/scripts/post-config.d/Install_Packages.sh"
local my_pkgs="/var/lib/my_packages/"
local FILES2RM=( ${rfc2136_tmpl} ${post_cfg} ${my_pkgs})

  for i in ${FILES2RM[@]}; do
    if
    then
      [[ -d "${i}" ]] try sudo rm -rf "${i}"
    fi
  done
}

main ()
{
  echo_logger I "This script will completely remove and erase all RFC 2136 DDNS support and reset the system hostname to 'ubnt'!"
  if yesno -y "Is that OK? [Y/n]: "
  then
    echo_logger I "Starting EdgeOS Router RFC 2136 DDNS configuration removal..."
    Delete_RFC2136
    echo_logger I "EdgeOS Router RFC 2136 DDNS configuration removal completed."
  else
    echo_logger I "EdgeOS Router RFC 2136 DDNS configuration removal canceled!"
  fi
}

# Now let's do it!
main
