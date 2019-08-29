# UBNT EdgeMax Integrated CLI RFC 2136 support for Edgerouters and UniFi Gateways

Follow the conversation @ [community.ubnt.com](https://community.ubnt.com/t5/EdgeRouter/edgeos-rfc2136-ddns-v1-2-2-Integrated-CLI-RFC-2136-support-for/td-p/1270181/jump-to/first-unread-message "Follow the conversation about this software in the EdgeRouter forum (https://community.ubnt.com/t5/EdgeRouter/)")

## Donations and Sponsorship

Please show your thanks by donating to the project using [Square Cash](https://cash.me/$HelmRockSecurity/ "Securely send and receive cash without fees using Square Cash") or [PayPal](https://www.paypal.me/helmrocksecurity/)

[![Donate](https://img.shields.io/badge/Donate-%245-orange.svg?style=plastic)](https://cash.me/$HelmRockSecurity/5 "Give $5 using Square Cash (free money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%2410-red.svg?style=plastic)](https://cash.me/$HelmRockSecurity/10 "Give $10 using Square Cash (free money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%2415-yellow.svg?style=plastic)](https://cash.me/$HelmRockSecurity/15 "Give $15 using Square Cash (free money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%2420-yellowgreen.svg?style=plastic)](https://cash.me/$HelmRockSecurity/20 "Give $20 using Square Cash (free money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%2425-brightgreen.svg?style=plastic)](https://cash.me/$HelmRockSecurity/25 "Give $25 using Square Cash (free money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%2450-ff69b4.svg?style=plastic)](https://cash.me/$HelmRockSecurity/50 "Give $50 using Square Cash (free money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%24100-blue.svg?style=plastic)](https://cash.me/$HelmRockSecurity/100 "Give $100 using Square Cash (free money transfer)")
[![Donate](https://img.shields.io/badge/Donate-Custom%20Amount-4B0082.svg?style=plastic)](https://cash.me/$HelmRockSecurity/ "Choose your own donation amount using Square Cash (free money transfer)")

[![Donate](https://img.shields.io/badge/Donate-%245-orange.svg?style=plastic)](https://paypal.me/helmrocksecurity/5 "Give $5 using PayPal (PayPal money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%2410-red.svg?style=plastic)](https://paypal.me/helmrocksecurity/10 "Give $10 using PayPal (PayPal money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%2415-yellow.svg?style=plastic)](https://paypal.me/helmrocksecurity/15 "Give $15 using PayPal (PayPal money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%2420-yellowgreen.svg?style=plastic)](https://paypal.me/helmrocksecurity/20 "Give $20 using PayPal (PayPal money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%2425-brightgreen.svg?style=plastic)](https://paypal.me/helmrocksecurity/25 "Give $25 using PayPal (PayPal money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%2450-ff69b4.svg?style=plastic)](https://paypal.me/helmrocksecurity/50 "Give $50 using PayPal (PayPal money transfer)")
[![Donate](https://img.shields.io/badge/Donate-%24100-blue.svg?style=plastic)](https://paypal.me/helmrocksecurity/100 "Give $100 using PayPal (PayPal money transfer)")
[![Donate](https://img.shields.io/badge/Donate-Custom%20Amount-4B0082.svg?style=plastic)](https://paypal.me/helmrocksecurity/ "Choose your own donation amount using PayPal (PayPal money transfer)")

We greatly appreciate any and all donations - Thank you! Funds go to maintaining development servers and networks.

NOTE: THIS IS NOT OFFICIAL UBIQUITI SOFTWARE AND THEREFORE NOT SUPPORTED OR ENDORSED BY Ubiquiti Networks®

## Overview

Adds EdgeOS DDNS templates for Cloudflare and RFC2136

## Copyright (C) 2019 by Helm Rock Consulting

## Licenses

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

* [Apache License V2.0](https://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Features

* Adds templates for RFC2136 and CloudFlare DDNS support to EdgeRouters
* Simple Debian package installation and removal

## Compatibility

|Type|Model|From Version|To Version|
|---|---|---:|---:|
|EdgeRouter|ERLite 3-Port|1.7.0|1.10.5|
|EdgeRouter|ERLite 5-Port|1.7.0|1.10.5|
|EdgeRouter|ER-X 5-Port|1.7.0|1.10.5|
|UniFi Gateway|USG 3|4.4.12|4.4.22.5086045|
|UniFi Gateway|USG Pro|4.4.12|4.4.22.5086045|

## Dependencies

* dnsutils

## Installation

* Install dnsutils:

```bash
configure
set system package repository wheezy components main
set system package repository wheezy distribution wheezy
set system package repository wheezy url 'http://archive.debian.org/debian'
commit;save;exit
sudo apt-get update
sudo apt-get install dnsutils
```

* Download the Debian package [edgeos-rfc2136-ddns_1.3.0_all.deb](https://github.com/britannic/EdgeMax-RFC2136-DDNS/raw/master/edgeos-rfc2136-ddns_1.3.0_all.deb) and install edgeos-rfc2136-ddns using:

```bash
curl -O https://github.com/britannic/EdgeMax-RFC2136-DDNS/raw/master/edgeos-rfc2136-ddns_1.3.0_all.deb
sudo dpkg -i edgeos-rfc2136-ddns_1.3.0_all.deb
```

## Configuration

* Here's an example configuration

```bash
configure
set system package repository wheezy components main
set system package repository wheezy distribution wheezy
set system package repository wheezy url 'http://archive.debian.org/debian'
set service dns dynamic interface eth1 rfc2136 testsvr.top.dog.com key /config/auth/keys/testsvr.private
set service dns dynamic interface eth1 rfc2136 testsvr.top.dog.com login /usr/bin/nsupdate
set service dns dynamic interface eth1 rfc2136 testsvr.top.dog.com record testsvr.top.dog.com
set service dns dynamic interface eth1 rfc2136 testsvr.top.dog.com server ns.top.dog.com
set service dns dynamic interface eth1 rfc2136 testsvr.top.dog.com ttl 3600
set service dns dynamic interface eth1 rfc2136 testsvr.top.dog.com zone top.dog.com
set service dns dynamic interface eth1 rfc2136 test.top.dog.com key /config/auth/keys/test.private
set service dns dynamic interface eth1 rfc2136 test.top.dog.com login /usr/bin/nsupdate
set service dns dynamic interface eth1 rfc2136 test.top.dog.com record test.top.dog.com
set service dns dynamic interface eth1 rfc2136 test.top.dog.com server ns.top.dog.com
set service dns dynamic interface eth1 rfc2136 test.top.dog.com ttl 3600
set service dns dynamic interface eth1 rfc2136 test.top.dog.com zone top.dog.com
commit;save;exit
```

* The resulting configuration stanzas will be stored in /config/config.boot as:

```bash
configure
nutter@myrouter# show system package repository wheezy
 repository wheezy {
     components main
     distribution wheezy
     url http://archive.debian.org/debian
 }

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
