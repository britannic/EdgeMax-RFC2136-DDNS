#!/usr/bin/env bash

target='/opt/vyatta/sbin/vyatta-dynamic-dns.pl'

[[ -e "${target}" ]] && echo "${DPKG_MAINTSCRIPT_PACKAGE} - backing up ${target}..."; cp "${target}" "${target}.bkp"