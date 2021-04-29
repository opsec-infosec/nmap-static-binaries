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

echo ""
echo -e "${GREEN}[+] Scanning for Detailed Ports${RESET}"
for i in $(cat ./output/$1_quick_tcp_nmap.txt | grep open | cut -d '/' -f1); do ./nmap -vv --reason -Pn -sV -p $i --script="default,banner,vuln" -oN "./output/"$1"_tcp_"$i"_naap.txt" $1; done;

cd ./output
echo ""
echo -e "[+] Archiving Nmap Scans"
tar -czvf nmap-scan-$1.tar.gz *.txt
rm -r *.txt
