#!/bin/bash

##
## Created by opinfosec
## https://github.com/opsec-infosec
##
##

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
WHITE='\033[0;37m'
RESET='\033[0m'


if  [[ ! -d ./output ]]; then
  mkdir ./output; fi

echo ""
echo -e "${GREEN}[+] Scanning port ${RESET} "$2" of host " $1 "\n"
./nmap -vv --reason -Pn -sV -p $2 --script=$3 -oN "./output/"$1"_tcp_"$2"_xxx_nmap.txt" $1

cd ./output
echo ""
echo -e "${GREEN}[+] Archiving the Results${reset}"
tar -czvf nmap-scan-port-$1.tar.gz *.txt
rm -r *.txt
echo ""
echo -e "${GREEN}--DONE--${RESET}"

