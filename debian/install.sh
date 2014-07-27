#!/bin/bash
if [ -d '/usr/local/nmd' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/nmd
fi
clear
echo; echo 'Installing No More DDOS 1.0 for Debian'; echo

#Config Files
echo; echo -n 'Downloading config files...'
mkdir /usr/local/nmd/conf.d
wget -q -O /usr/local/nmd/conf.d/agent.conf https://raw.githubusercontent.com/stylersnico/nmd/master/debian/conf.d/agent.conf
echo -n '.'

wget -q -O /usr/local/nmd/conf.d/ignore.ip.list https://raw.githubusercontent.com/stylersnico/nmd/master/debian/conf.d/ignore.ip.list
echo -n '.'

#Scripts Files
echo; echo -n 'Downloading scripts files...'
mkdir /usr/local/nmd/scripts
wget -q -O /usr/local/nmd/scripts/ban.sh https://raw.githubusercontent.com/stylersnico/nmd/master/debian/scripts/ban.sh
echo -n '.'
chmod 0755 /usr/local/nmd/scripts/ban.sh

wget -q -O /usr/local/nmd/scripts/default-config.sh https://raw.githubusercontent.com/stylersnico/nmd/master/debian/scripts/default-config.sh
echo -n '.'
chmod 0755 /usr/local/nmd/scripts/default-config.sh

wget -q -O /usr/local/nmd/scripts/error.sh https://raw.githubusercontent.com/stylersnico/nmd/master/debian/scripts/error.sh
echo -n '.'
chmod 0755 /usr/local/nmd/scripts/error.sh

wget -q -O /usr/local/nmd/scripts/reset-log.sh https://raw.githubusercontent.com/stylersnico/nmd/masterdebian/scripts/reset-log.sh
echo -n '.'
chmod 0755 /usr/local/nmd/scripts/reset-log.sh

wget -q -O /usr/local/nmd/scripts/show-ban.sh https://raw.githubusercontent.com/stylersnico/nmd/master/debian/scripts/show-ban.sh
echo -n '.'
chmod 0755 /usr/local/nmd/scripts/show-ban.sh

wget -q -O /usr/local/nmd/scripts/unban.sh https://raw.githubusercontent.com/stylersnico/nmd/master/debian/scripts/unban.sh
echo -n '.'
chmod 0755 /usr/local/nmd/scripts/unban.sh

#White-list system
echo; echo -n 'Downloading white-list system...'
mkdir /usr/local/nmd/white-list
wget -q -O /usr/local/nmd/white-list/white-list.sh https://raw.githubusercontent.com/stylersnico/nmd/master/debian/white-list/white-list.sh
echo -n '.'
chmod 0755 /usr/local/nmd/white-list/white-list.sh

wget -q -O /usr/local/nmd/white-list/white.list https://raw.githubusercontent.com/stylersnico/nmd/master/debian/white-list/white.list
echo -n '.'

#Installing base system
echo; echo -n 'Downloading base system...'
wget -q -O /usr/local/nmd/nmd https://raw.githubusercontent.com/stylersnico/nmd/master/debian/nmd
echo -n '.'
chmod 0755 /usr/local/nmd/nmd

wget -q -O /usr/local/nmd/nmd-agent.sh https://raw.githubusercontent.com/stylersnico/nmd/master/debian/nmd-agent.sh
echo -n '.'
chmod 0755 /usr/local/nmd/nmd-agent.sh

wget -q -O /usr/local/nmd/LICENSE https://raw.githubusercontent.com/stylersnico/nmd/master/debian/LICENSE
echo -n '.'

echo '...done'
echo '.....done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/nmd/nmd-agent.sh -c
echo '.....done'
echo; echo 'Installation has completed.'
echo; echo 'Use /usr/local/nmd/nmd to configure No More DDOS'
echo 'Config file is at /usr/local/nmd/conf.d/agent.conf'
echo '/usr/local/nmd/white-list/white.list'
echo 'Please send in your comments and/or suggestions to contact@nicolas-simond.com'

 echo 'Launching the No More DDOS agent ...';sleep 5
/usr/local/nmd/nmd
