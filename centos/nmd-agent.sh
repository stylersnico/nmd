#!/bin/bash
##############################################################################
# Based on the Zaf <zaf@vsnl.com> work                                       #
# No More DDOS by Nicolas Simond <contact@nicolas-simond.com>                #
##############################################################################
# This program is distributed under the "Artistic License" Agreement         #
#                                                                            #
# The LICENSE file is located in the same directory as this program. Please  #
#  read the LICENSE file before you make copies or distribute this program.  #
##############################################################################
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
load_conf()
{
	CONF="/usr/local/nmd/conf.d/agent.conf"
	if [ -f "$CONF" ] && [ ! "$CONF" =	"" ]; then
		. $CONF
	else
		head
		echo "\$CONF not found."
		exit 1
	fi
}

head()
{
	echo ' _   _  ___    __  __  ___  ____  _____   ____  ____   ___  ____'
	echo '| \ | |/ _ \  |  \/  |/ _ \|  _ \| ____| |  _ \|  _ \ / _ \/ ___|'
	echo '|  \| | | | | | |\/| | | | | |_) |  _|   | | | | | | | | | \___ \'
	echo '| |\  | |_| | | |  | | |_| |  _ <| |___  | |_| | |_| | |_| |___) |'
	echo '|_| \_|\___/  |_|  |_|\___/|_| \_\_____| |____/|____/ \___/|____/'
	echo
	echo
}
showhelp()
{
	head
	echo 'Usage: nmd-agent.sh [OPTIONS] [N]'
	echo 'N : number of tcp/udp	connections (default 250)'
	echo 'OPTIONS:'
	echo '-h | --help: Show	this help screen'
	echo '-c | --cron: Create cron job to run this script regularly (default 1 mins)'
	echo '-k | --kill: Block the offending ip making more than N connections'
}

unbanip()
{
	UNBAN_SCRIPT=`mktemp /tmp/unban.XXXXXXXX`
	TMP_FILE=`mktemp /tmp/unban.XXXXXXXX`
	UNBAN_IP_LIST=`mktemp /tmp/unban.XXXXXXXX`
	echo '#!/bin/sh' > $UNBAN_SCRIPT
	echo "sleep $BAN_PERIOD" >> $UNBAN_SCRIPT
	if [ $APF_BAN -eq 1 ]; then
		while read line; do
			echo "$APF -u $line" >> $UNBAN_SCRIPT
			echo $line >> $UNBAN_IP_LIST
		done < $BANNED_IP_LIST
	else
		while read line; do
			echo "$IPT -D INPUT -s $line -j DROP" >> $UNBAN_SCRIPT
			echo $line >> $UNBAN_IP_LIST
		done < $BANNED_IP_LIST
	fi
	echo "grep -v --file=$UNBAN_IP_LIST $IGNORE_IP_LIST > $TMP_FILE" >> $UNBAN_SCRIPT
	echo "mv $TMP_FILE $IGNORE_IP_LIST" >> $UNBAN_SCRIPT
	echo "rm -f $UNBAN_SCRIPT" >> $UNBAN_SCRIPT
	echo "rm -f $UNBAN_IP_LIST" >> $UNBAN_SCRIPT
	echo "rm -f $TMP_FILE" >> $UNBAN_SCRIPT
	. $UNBAN_SCRIPT &
}

add_to_cron()
{
	rm -f $CRON
	echo '--> Creating new cron'
	echo
	sleep 1
	service crond restart
	sleep 1
	if [ $FREQ -le 2 ]; then
		echo "0-59/$FREQ * * * * root /usr/local/nmd/nmd-agent.sh >> /var/log/nmd-agent.log" >> $CRON
	else
		let "START_MINUTE = $RANDOM % ($FREQ - 1)"
		let "START_MINUTE = $START_MINUTE + 1"
		let "END_MINUTE = 60 - $FREQ + $START_MINUTE"
		echo "$START_MINUTE-$END_MINUTE/$FREQ * * * * root /usr/local/nmd/nmd-agent.sh >> /var/log/nmd-agent.log" >> $CRON
	fi
	service crond restart
	echo
	echo '--> Done'
	echo
}


load_conf
while [ $1 ]; do
	case $1 in
		'-h' | '--help' | '?' )
			showhelp
			exit
			;;
		'--cron' | '-c' )
			add_to_cron
			exit
			;;
		'--kill' | '-k' )
			KILL=1
			;;
		 *[0-9]* )
			NO_OF_CONNECTIONS=$1
			;;
		* )
			showhelp
			exit
			;;
	esac
	shift
done

TMP_PREFIX='/tmp/unban'
TMP_FILE="mktemp $TMP_PREFIX.XXXXXXXX"
BANNED_IP_MAIL=`$TMP_FILE`
BANNED_IP_LIST=`$TMP_FILE`
echo "Banned the following ip addresses on `date`" > $BANNED_IP_MAIL
echo >>	$BANNED_IP_MAIL
BAD_IP_LIST=`$TMP_FILE`

#WHITELIST LOAD
WHITE_LIST=/usr/local/nmd/white-list/white.list

#NETSTAT CMD
date -u
echo 'Connections | IP'
echo 
netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | $WHITE_LIST > $BAD_IP_LIST
cat $BAD_IP_LIST
echo
echo
echo '========================================================================='
if [ $KILL -eq 1 ]; then
	IP_BAN_NOW=0
	while read line; do
		CURR_LINE_CONN=$(echo $line | cut -d" " -f1)
		CURR_LINE_IP=$(echo $line | cut -d" " -f2)
		if [ $CURR_LINE_CONN -lt $NO_OF_CONNECTIONS ]; then
			break
		fi
		IGNORE_BAN=`grep -c $CURR_LINE_IP $IGNORE_IP_LIST`
		if [ $IGNORE_BAN -ge 1 ]; then
			continue
		fi
		IP_BAN_NOW=1
		echo "$CURR_LINE_IP with $CURR_LINE_CONN connections" >> $BANNED_IP_MAIL
		echo $CURR_LINE_IP >> $BANNED_IP_LIST
		echo $CURR_LINE_IP >> $IGNORE_IP_LIST
		if [ $APF_BAN -eq 1 ]; then
			$APF -d $CURR_LINE_IP
		else
			$IPT -I INPUT -s $CURR_LINE_IP -j DROP
		fi
	done < $BAD_IP_LIST
	if [ $IP_BAN_NOW -eq 1 ]; then
		dt=`date`
		if [ $EMAIL_TO != "" ]; then
			cat $BANNED_IP_MAIL | mail -s "IP addresses banned on $dt" $EMAIL_TO
		fi
		unbanip
	fi
fi
rm -f $TMP_PREFIX.*
echo
echo
