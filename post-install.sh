#!/usr/bin/env bash

target='/opt/vyatta/sbin/vyatta-dynamic-dns.pl'

if [[ -e ${target}.dpkg ]]; then
  if ! cmp -s ${target}.dpkg ${target}; then
    echo "${DPKG_MAINTSCRIPT_PACKAGE} - restoring ${target}..."
    mv "${target}.dpkg" "${target}"
  fi
fi