#!/bin/bash
echo "Config!"

line=$(grep -n 'webservergroup' localconfig | cut -d ":" -f 1)
ch="webservergroup = 'www-data';"
echo $line
sed -i "$line"d localconfig
sed -i ${line}i\$"$ch" localconfig

line=$(grep -n 'db_host' localconfig | cut -d ":" -f 1)
ch="db_host = '"$DB_ADDR"';"
echo $line
sed -i "$line"d localconfig
sed -i ${line}i\$"$ch" localconfig


line=$(grep -n 'db_user' localconfig | cut -d ":" -f 1)
ch="db_user = '"$DB_USER"';"
echo $line
sed -i "$line"d localconfig
sed -i ${line}i\$"$ch" localconfig

line=$(grep -n 'db_pass' localconfig | cut -d ":" -f 1)
ch="db_pass = '"$DB_PWD"';"
echo $line
sed -i "$line"d localconfig
sed -i ${line}i\$"$ch" localconfig

line=$(grep -n 'db_port' localconfig | cut -d ":" -f 1)
ch="db_port = "$DB_PORT";"
echo $line
sed -i "$line"d localconfig
sed -i ${line}i\$"$ch" localconfig

cd /etc/apache2/sites-available/
line=$(grep -n 'DocumentRoot' 000-default.conf | cut -d ":" -f 1)
echo $line
sed -i ${line}s:$:/bugzilla: 000-default.conf
cd -

cd /etc/apache2/conf-available/
line=$(grep -n "Tokens OS" security.conf |cut -d ":" -f 1)
echo $line
sed -i "${line}s/OS/Prod/g" security.conf
line=$(grep -n "ServerSignature On" security.conf |cut -d ":" -f 1)
echo $line
sed -i "${line}s/On/Off/g" security.conf
cd -
