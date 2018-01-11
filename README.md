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
* Simple Debian package installation and removal

## Compatibility
* Tested on EdgeRouter:
  - EdgeRouter Lite 3-Port v1.7.0-v1.9.7+hotfix.4
  - EdgeRouter Lite 5-Port v1.7.0-v1.9.7+hotfix.4
  - ER-X v1.9.7+hotfix.4
  - UniFi-Gateway-3 v4.4.12
  
## Dependencies
* dnsutils

## Installation
* Install dnsutils:

        sudo apt-get update
        sudo apt-get install dnsutils

* Download the Debian package [edgeos-rfc2136-ddns_1.2.1_all.deb](https://github.com/britannic/EdgeMax-RFC2136-DDNS/raw/master/edgeos-rfc2136-ddns_1.2.1_all.deb)

  - Install edgeos-rfc2136-ddns using:
  
        sudo dpkg -i edgeos-rfc2136-ddns_1.2.1_all.deb
