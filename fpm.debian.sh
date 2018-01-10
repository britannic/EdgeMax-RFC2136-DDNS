#!/usr/bin/env bash

export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
export COPYFILE_DISABLE=true
drop="$HOME/Dropbox/EdgeOS"
arch='all'
dep='dnsutils'
desc='Adds EdgeOS DDNS configuration templates for Cloudflare and RFC2136'
dir='/tmp/'
dist='deb'
exc1=\**/.DS_Store
exc2=\**/sbin
host='dev1'
lic='http://www.apache.org/licenses/LICENSE-2.0'
mntr="${pkg}@helmrock.com"
pkg='edgeos-rfc2136-ddns'
post='./post-install.sh'
pre='./pre-install.sh'
prov='Adds EdgeOS DDNS configuration templates for Cloudflare and RFC2136'
sdir='payload/rfc2136.dynamic.dns/'
src1='usr/'
src2='opt/'
url='https://github.com/britannic/EdgeMax-RFC2136-DDNS'
vend='Helm Rock Consulting'
ver=$(cat VERSION)

bundle ()
{
  cwd=$(pwd)
  local dir='./payload/rfc2136.dynamic.dns/opt/vyatta/sbin'
  local target='vyatta-dynamic-dns.pl'
  local templt='decompress_pre-install'

  cat "${templt}" > "${pre}"
  cd "${dir}"

  tar -zc \
  --exclude='._*' \
  --exclude='.svn' \
  --exclude='.DS_Store' \
  --exclude='*.bak' \
  --exclude='*~' \
  ./* >> "${cwd}/${pre}"
  cd "${cwd}"
}

make_debian ()
{
  fpm \
    -f \
    --after-remove "${post}" \
    --before-install "${pre}" \
    --deb-pre-depends "${dep}" \
    --description "${desc}" \
    --license "${lic}" \
    --provides "${prov}" \
    --url "${url}" \
    --vendor "${vend}" \
    --verbose \
    -a "${arch}" \
    -C "${sdir}" \
    -m "${mntr}" \
    -n "${pkg}"  \
    -t "${dist}" \
    -v "${ver}"  \
    -x "${exc1}" \
    -x "${exc2}" \
    -s dir "${src1}" "${src2}"
}

update_dropbox () {
  [[ -d "${drop}/" ]] && install -m 0755 "${pkg}_${ver}_${arch}.${dist}" "${drop}/"
}

upload () {
  scp "${pkg}_${ver}_${arch}.${dist}" "${host}:${dir}"
}

# Build it!
bundle && make_debian && update_dropbox && upload
