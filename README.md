# UBNT EdgeMax Scripts and Utilities
http://community.ubnt.com/t5/EdgeMAX

NOTE: THIS IS NOT OFFICIAL UBIQUITI SOFTWARE AND THEREFORE NOT SUPPORTED OR ENDORSED BY Ubiquiti Networks®

## Overview
Adds EdgeOS DDNS templates for Cloudflare and RFC2136

# Copyright (C) 2018 by Helm Rock Consulting

## Licenses
#
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

* http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Features

* Adds templates for RFC2136 and CloudFlare DDNS support to EdgeRouters
* Simple Debian package installation and removal

## Compatibility

* Tested on EdgeRouter:
  - EdgeRouter ERLite 3-Port v1.7.0-v1.10
  - EdgeRouter ERLite 5-Port v1.7.0-v1.10
  - ER-X v1.7.0-v1.10
  - UniFi-Gateway-3 v4.4.12-4.4.18

## Dependencies

* dnsutils

## Installation

* Install dnsutils:

```bash
sudo apt-get update
sudo apt-get install dnsutils
```

* Download the Debian package [edgeos-rfc2136-ddns_1.2.2_all.deb](https://github.com/britannic/EdgeMax-RFC2136-DDNS/raw/master/edgeos-rfc2136-ddns_1.2.2_all.deb) and install edgeos-rfc2136-ddns using:

```bash
curl -O https://github.com/britannic/EdgeMax-RFC2136-DDNS/raw/master/edgeos-rfc2136-ddns_1.2.2_all.deb
sudo dpkg -i edgeos-rfc2136-ddns_1.2.2_all.deb
```

## Configuration

* Here's an example configuration

```bash
set service dns dynamic interface eth1 rfc2136 testsvr.top.dog.com key /config/auth/keys/testsvr.private
set service dns dynamic interface eth1 rfc2136 testsvr.top.dog.com login /usr/bin/nsupdate
set service dns dynamic interface eth1 rfc2136 testsvr.top.dog.com record testsvr.top.dog.com
set service dns
dynamic interface eth1 rfc2136 testsvr.top.dog.com server ns.top.dog.com
set service dns dynamic interface eth1 rfc2136 testsvr.top.dog.com ttl 3600
set service dns dynamic interface eth1 rfc2136 testsvr.top.dog.com zone top.dog.com
set service dns dynamic interface eth1 rfc2136 test.top.dog.com key /config/auth/keys/test.private
set service dns dynamic interface eth1 rfc2136 test.top.dog.com login /usr/bin/nsupdate
set service dns dynamic interface eth1 rfc2136 test.top.dog.com record test.top.dog.com
set service dns dynamic interface eth1 rfc2136 test.top.dog.com server ns.top.dog.com
set service dns dynamic interface eth1 rfc2136 test.top.dog.com ttl 3600
set service dns dynamic interface eth1 rfc2136 test.top.dog.com zone top.dog.com
```

* The resulting configuration stanzas will be stored in /config/config.boot as:

```bash
nutter@myrouter# show service dns dynamic interface eth1 rfc2136 
 rfc2136 test2.top.dog.com {
     key /config/auth/keys/test.private
     login /usr/bin/nsupdate
     record test.top.dog.com
     server ns.top.dog.com
     ttl 3600
     zone top.dog.com
 }
 rfc2136 testsvr.top.dog.com {
     key /config/auth/keys/testsvr.private
     login /usr/bin/nsupdate
     record testsvr.top.dog.com
     server ns.top.dog.com
     ttl 3600
     zone top.dog.com
 }
```