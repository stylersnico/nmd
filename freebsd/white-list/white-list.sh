#!/bin/bash
clear
echo -e "\e[1;31m"
echo ' _   _  ___    __  __  ___  ____  _____   ____  ____   ___  ____'
echo '| \ | |/ _ \  |  \/  |/ _ \|  _ \| ____| |  _ \|  _ \ / _ \/ ___|'
echo '|  \| | | | | | |\/| | | | | |_) |  _|   | | | | | | | | | \___ \'
echo '| |\  | |_| | | |  | | |_| |  _ <| |___  | |_| | |_| | |_| |___) |'
echo '|_| \_|\___/  |_|  |_|\___/|_| \_\_____| |____/|____/ \___/|____/'
echo '=================================================================='
echo
echo -e "\e[0m"
echo
echo -e "--> Enter IP to \e[97mwhitelist \e[39m(xxx.xxx.xxx.xxx format)"
echo ""
read IP
echo " -e $IP" >> /usr/local/nmd/white-list/white.list
sed -i '{:q;N;s/\n//g;t q}' /usr/local/nmd/white-list/white.list
echo ""
echo "--> Done !"
echo ""
echo "--> This is your current white list :"
cat /usr/local/nmd/white-list/white.list
