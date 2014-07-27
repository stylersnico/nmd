#!/bin/bash
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing No More DDOS 1.0 for Debian'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/nmd/ddos.conf https://raw.githubusercontent.com/stylersnico/DDOS-Deflate-for-Debian-7/master/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE https://raw.githubusercontent.com/stylersnico/DDOS-Deflate-for-Debian-7/master/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list https://raw.githubusercontent.com/stylersnico/DDOS-Deflate-for-Debian-7/master/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh https://raw.githubusercontent.com/stylersnico/DDOS-Deflate-for-Debian-7/master/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo -n '.'
wget -q -O /usr/local/ddos/update.sh https://raw.githubusercontent.com/stylersnico/DDOS-Deflate-for-Debian-7/master/update.sh
chmod 0755 /usr/local/ddos/update.sh
wget -q -O /usr/local/ddos/white.list https://raw.githubusercontent.com/stylersnico/DDOS-Deflate-for-Debian-7/master/white.list
chmod 0755 /usr/local/ddos/white.list
echo '...done'
echo '.....done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh -c
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'New White List file is at /usr/local/ddos/white.list'
echo 'Please send in your comments and/or suggestions to contact@nicolas-simond.com'
