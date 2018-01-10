#!/usr/bin/env bash

arch="all"
dir="/tmp/"
dist="deb"
host="dev1"
pkg="edgeos-rfc2136"
ver=$(cat VERSION)

fpm -f \
    --description "Adds EdgeOS DDNS templates for Cloudflare and RFC2136" \
    --license "http://www.apache.org/licenses/LICENSE-2.0" \
    --replaces vyatta-cfg-system \
    --verbose \
    -a ${arch} \
    -C payload/rfc2136.dynamic.dns/ \
    -m "Helm Rock Consulting" \
    -n ${pkg}  \
    --deb-pre-depends dnsutils \
    -t ${dist} \
    -v ${ver}  \
    -x \**/.DS_Store \
    -s dir usr/ opt/ \
    && scp "${pkg}_${ver}_${arch}.${dist}" ${host}:${dir}