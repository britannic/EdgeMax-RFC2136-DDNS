#!/usr/bin/env bash

target='/opt/vyatta/sbin/vyatta-dynamic-dns.pl'

if [[ -e "${target}.bkp" ]]; then
  echo "${DPKG_MAINTSCRIPT_PACKAGE} - restoring ${target}..."
  mv "${target}.bkp" "${target}"
fi