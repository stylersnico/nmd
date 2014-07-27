#!/bin/bash
echo; echo "Uninstalling No More DDOS"
echo; echo; echo -n "Deleting all files....."
if [ -d '/usr/local/nmd' ]; then
	rm -rf /usr/local/nmd
	echo -n ".."
fi
echo "done !"

echo; echo; echo -n "Deleting cronjob....."
if [ -d '/etc/cron.d/nmd' ]; then
	rm -f /etc/cron.d/nmd.cron
	echo -n ".."
fi
echo "done !"

echo; echo "Uninstall Complete"; echo
