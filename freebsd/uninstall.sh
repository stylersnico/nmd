#!/bin/bash
echo; echo "Uninstalling No More DDOS"
echo; echo; echo -n "Deleting all files....."
if [ -d '/usr/local/nmd' ]; then
	rm -rf /usr/local/nmd
	echo -n ".."
fi
echo "done !"

echo; echo; echo -n "Deleting log....."
if [ -d '/var/log/nmd-agent.log' ]; then
	rm -f /var/log/nmd-agent.log
	echo -n ".."
fi
echo "done !"

echo; echo "Uninstall Complete - Please clean the cron manually"; echo
