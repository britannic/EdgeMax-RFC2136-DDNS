#!/usr/bin/env bash

arch='all'
dep='dnsutils'
desc='Adds EdgeOS DDNS configuration templates for Cloudflare and RFC2136'
dir='/tmp/'
dist='deb'
host='dev1'
lic='http://www.apache.org/licenses/LICENSE-2.0'
pkg='edgeos-rfc2136-ddns'
post='./post-install.sh'
pre='./pre-install.sh'
sdir='payload/rfc2136.dynamic.dns/'
src1='usr/'
src2='opt/'
upgr='vyatta-cfg-system'
url='https://github.com/britannic/EdgeMax-RFC2136-DDNS'
ver=$(cat VERSION)
who='Helm Rock Consulting'

fpm \
    -f \
    --after-remove "${post}" \
    --before-install "${pre}" \
    --deb-pre-depends "${dep}" \
    --description "${desc}" \
    --license "${lic}" \
    --replaces "${upgr}" \
    --url "${url}" \
    --vendor "${who}" \
    --verbose \
    -a "${arch}" \
    -C "${sdir}" \
    -m "${who}" \
    -n "${pkg}"  \
    -t "${dist}" \
    -v "${ver}"  \
    -x \**/.DS_Store \
    -s dir "${src1}" "${src2}" \
    && scp "${pkg}_${ver}_${arch}.${dist}" "${host}:${dir}"