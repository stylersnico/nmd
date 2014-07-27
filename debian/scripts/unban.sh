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
echo -e "--> Enter IP to \e[92munban\e[39m (xxx.xxx.xxx.xxx format)"
echo ""
read IP
echo
iptables -D INPUT -s "$IP" -j DROP
echo -e "--> Do you want to add this IP in the \e[97mWhite List\e[39m ?"
echo '	--> 1 for Yes'
echo '	--> 2 for No'
echo
echo "Choose :"
read choose
case $choose in
    1) clear && echo " -e $IP" >> /usr/local/nmd/white-list/white.list && sed -i '{:q;N;s/\n//g;t q}' /usr/local/nmd/white-list/white.list&& echo "--> This is your current white list :" && cat /usr/local/nmd/white-list/white.list;;
    2) clear;;
    *) invalid option;;
esac