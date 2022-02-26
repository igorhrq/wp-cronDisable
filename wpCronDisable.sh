#!/bin/bash
# Author: Igor Andrade
# 26/02/2022
# first day of the month and 15
# 0 4 1,15 * * /bin/bash <(curl -ks https://raw.githubusercontent.com/igorhrq/wp-cronDisable/main/wpCronDisable.sh) > /dev/null 2>&1

DATA=$(date +%d-%m-%Y)
LOGS="/var/log/script-wpcron-disable.log"
> $LOGS
for filez in $(find /home/ -iname "wp-config.php") 
do 
echo -e "checking file $filez"
	if egrep DISABLE_WP_CRON $filez >> /dev/null 2>&1
	then
		echo -e "Alredy disabled on $filez on $DATA" | tee -a $LOGS
	else
		echo -e "Enabling on $filez on $DATA" | tee -a $LOGS
		sed -i "/DB_NAME/a define\(\'DISABLE_WP_CRON\'\, true\)\;" $filez
	fi
done
