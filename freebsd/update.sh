#!/bin/bash
clear
echo; echo 'Updating No More DDOS for freebsd to 2015v1 Release'; echo

#Config Files
echo; echo -n 'Downloading new config files...'
wget --no-check-certificate -q -O /usr/local/nmd/conf.d/agent.conf https://raw.githubusercontent.com/stylersnico/nmd/master/freebsd/conf.d/agent.conf
echo -n '.'
wget --no-check-certificate -q -O /usr/local/nmd/conf.d/ignore.ip.list https://raw.githubusercontent.com/stylersnico/nmd/master/freebsd/conf.d/ignore.ip.list
echo -n '.'
chmod 0755 /usr/local/nmd/conf.d/ignore.ip.list


#Base system
echo; echo -n 'Downloading new base system...'
wget --no-check-certificate -q -O /usr/local/nmd/nmd-agent.sh https://raw.githubusercontent.com/stylersnico/nmd/master/freebsd/nmd-agent.sh
echo -n '.'
chmod 0755 /usr/local/nmd/nmd-agent.sh

wget --no-check-certificate -q -O /usr/local/nmd/LICENSE https://raw.githubusercontent.com/stylersnico/nmd/master/freebsd/LICENSE
echo -n '.'

echo '...done'
echo '.....done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
sh /usr/local/nmd/nmd-agent.sh -c
echo '.....done'
echo; echo 'Update has completed.'
echo; echo 'Use sh /usr/local/nmd/nmd to configure No More DDOS'
echo 'Config file is at /usr/local/nmd/conf.d/agent.conf'
echo '/usr/local/nmd/white-list/white.list'
echo 'Please send in your comments and/or suggestions to contact@nicolas-simond.com'
