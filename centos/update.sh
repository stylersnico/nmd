#!/bin/bash
clear
echo; echo 'Updating No More DDOS for CentOS 7'; echo

#Config Files
echo; echo -n 'Downloading new config files...'
mkdir /usr/local/nmd/conf.d
wget -q -O /usr/local/nmd/conf.d/agent.conf https://raw.githubusercontent.com/stylersnico/nmd/master/centos/conf.d/agent.conf
echo -n '.'
wget -q -O /usr/local/nmd/conf.d/ignore.ip.list https://raw.githubusercontent.com/stylersnico/nmd/master/centos/conf.d/ignore.ip.list
echo -n '.'
chmod 0755 /usr/local/nmd/conf.d/ignore.ip.list


#Base system
echo; echo -n 'Downloading new base system...'
wget -q -O /usr/local/nmd/nmd-agent.sh https://raw.githubusercontent.com/stylersnico/nmd/master/centos/nmd-agent.sh
echo -n '.'
chmod 0755 /usr/local/nmd/nmd-agent.sh

wget -q -O /usr/local/nmd/LICENSE https://raw.githubusercontent.com/stylersnico/nmd/master/centos/LICENSE
echo -n '.'

echo '...done'
echo '.....done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/nmd/nmd-agent.sh -c
echo '.....done'
echo; echo 'Update has completed.'
echo; echo 'Use /usr/local/nmd/nmd to configure No More DDOS'
echo 'Config file is at /usr/local/nmd/conf.d/agent.conf'
echo '/usr/local/nmd/white-list/white.list'
echo 'Please send in your comments and/or suggestions to contact@nicolas-simond.com'
