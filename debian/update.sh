#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
echo -e "\e[1;31m"
echo; echo 'Updating ...'; echo
clear
echo ' _   _  ___    __  __  ___  ____  _____   ____  ____   ___  ____'
echo '| \ | |/ _ \  |  \/  |/ _ \|  _ \| ____| |  _ \|  _ \ / _ \/ ___|'
echo '|  \| | | | | | |\/| | | | | |_) |  _|   | | | | | | | | | \___ \'
echo '| |\  | |_| | | |  | | |_| |  _ <| |___  | |_| | |_| | |_| |___) |'
echo '|_| \_|\___/  |_|  |_|\___/|_| \_\_____| |____/|____/ \___/|____/'
echo '=================================================================='
echo
echo -e "\e[0m"
echo
echo; echo -n 'Downloading news files...'
wget -q -O /usr/local/ddos/LICENSE https://raw.githubusercontent.com/stylersnico/DDOS-Deflate-for-Debian-7/master/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh https://raw.githubusercontent.com/stylersnico/DDOS-Deflate-for-Debian-7/master/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
echo '...done'
echo; echo 'Update has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to contact@nicolas-simond.com'
