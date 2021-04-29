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
echo -e "${GREEN}[+] Running Quick Scan${RESET}"
./nmap -vv --reason -Pn -sV -sC --version-all -oN "./output/"$1"_quick_tcp_nmap.txt" $1
echo ""
echo -e "${GREEN}[+] Running Top 20 UDP${RESET}"
./nmap -vv --reason -Pn -sU -A --top-ports=20 --version-all -oN "./output/"$1"_top_20_udp_nmap.txt" $1
echo ""
echo -e "${GREEN}[+] Running Full TCP Scan${RESET}"
./nmap -vv --reason -Pn -A --osscan-guess --version-all -p- -oN "./output/"$1"_full_tcp_nmap.txt" $1

cd ./output
echo ""
echo -e "${GREEN}[+] Archiving Nmap Scans${RESET}"
tar -czvf nmap-scan-$1.tar.gz *.txt
rm -r *.txt
echo ""
echo -e "${GREEN}--DONE--${RESET}"
