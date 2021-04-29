# nmap-static-binaries

Pivoting with static binaries

# Linux Arch Types

There are 2 different version of static nmap binaries, one is for x86 architectures and the other is for x64.  Included in the repository are two .gz files that have already been compiled with version 7.91 of Nmap.  If you don't need to modify the nmap version, you can just grab those two .gz files and unarchive them on your target.

# Compiling

Included in the repository is a docker file and build.sh for compiling the static binaries.  The latest version of nmap (7.91) was used in the nmap.tar.gz archives.

# Usage

## scan.sh

The script scan.sh takes the ip address as an argument.  The script will execute 3 different types of scans concurrently:

1.  quick TCP nmap scan
2.  Top 20 UDP scan
3.  Full TCP scan

When all the scans are complete, the shell script will archive the resulting scans in the output folder, with the name nmap-scan-<IP>.tar.gz

The shell script is executed as follows:

scan.sh \<IP Address of Target\>

*Example*

```sh
scan.sh 192.168.0.1
```

## scan-port.sh

This script does a detailed scan of the target by port number and script type.  As with the scan.sh, the output is then archived in the output directory with the name nmap-scan-port-\<IP\>.tar.gz

The shell script is executed as follows:

scan-port.sh \<IP Address of Target\> \<PORT Number\> \<NSE Script to execute\>

*Example*

```
scan-port.sh 192.168.0.1 80 "http*, banner, vuln"
```

## full-scan.sh

This script will perform the same initial scans as the scan.sh script, but will also scan ports that are found by the quick scans.  
***NOTE:*** Quick scanning will only pull the most popular ports, there for the full scan may miss some ports found by the full scan.

The shell scrip is executed as follows:

full-scan.sh \<IP\>

As with the other scripts, the output is then archived in the output directory with the name nmap-scan-\<IP\>

*Example*

```
full-scan.sh 192.168.0.1
```

## Inside the Archive, naming convention

- Quick Scans
  - \<IP\>_quick_tcp_nmap.txt
- UDP Top 20
  - \<IP\>_top_20_udp_nmap.txt
- Full TCP Scan
  - \<IP\>_full_tcp_nmap.txt
- Individual Port Scans
  - \<IP\>_tcp_\<port\>_nmap.txt

# Credits

The build scripts are taken from Andrew-d's github page at https://github.com/andrew-d/static-binaries
