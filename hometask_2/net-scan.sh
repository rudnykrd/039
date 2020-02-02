#!/bin/bash

## Define the range of ip addresses in bash range format {xxx..xxx}.{xxx..xxx}.{xxx..xxx}.{xxx..xxx}
## e.g. 172.16.{13..15}.{0..255}

RESET='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'

echo -e "$RED----------- checking port 80/tcp ------------$RESET"
for ip in $@; do nc -zv -w 1 $ip 80 2>&1 | grep 'succeeded'; done
echo -e "$GREEN----------- checking port 443/tcp -----------$RESET"
for ip in $@; do nc -zv -w 1 $ip 443 2>&1 | grep 'succeeded'; done