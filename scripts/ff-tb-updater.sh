#!/bin/bash
#
# Author: Morfik
# Version: 0.0.1
# Date: 2015.03.22
#
# See: https://wiki.mozilla.org/Software_Update:Manually_Installing_a_MAR_file
#

ff() {
	instalation_dir="/opt/firefox"
	tmp_dir="/tmp/ff/out"
	lang="en-US"
	installed_verion=$($instalation_dir/firefox -v 2> /dev/null | grep Firefox | cut -d " " -f 3)
	ff_url="http://download-origin.cdn.mozilla.net/pub/mozilla.org/firefox/releases/latest/update/linux-`uname -m`/$lang/"  
	new_version=$(curl -s $ff_url | egrep -o -e "firefox\-$installed_verion\-[0-9]*\.[0-9]*\.[0-9]*\.partial\.mar" | sort -u | cut -d "-" -f 3 |cut -d "." -f 1-3)

	mkdir -p $tmp_dir
	
	echo -en "Installed version \033[01;32m$installed_verion\033[0m, "

	if [ -z $new_version ]; then
		echo -e "\033[01;32mno updates!\033[0m"
		rm -R $tmp_dir
		exit 0
	else
		echo -e "updating to the version \033[01;32m$new_version\033[0m ..."
	fi
	
	wget -O /tmp/ff/out/update.mar $ff_url/$update_ff 
	cd $instalation_dir
	cp $instalation_dir/updater $tmp_dir
	$tmp_dir/updater $tmp_dir $instalation_dir $instalation_dir

	rm -R $tmp_dir
}

tb() {
	instalation_dir="/opt/thunderbird"
	tmp_dir="/tmp/tb/out"
	lang="en-US"
	installed_verion=$($instalation_dir/thunderbird -v 2> /dev/null | grep Thunderbird | cut -d " " -f 2)
	tb_url="http://download-origin.cdn.mozilla.net/pub/mozilla.org/thunderbird/releases/latest/update/linux-`uname -m`/$lang/" 
	new_version=$(curl -s $tb_url | egrep -o -e "thunderbird\-$installed_verion\-[0-9]*\.[0-9]*\.[0-9]*\.partial\.mar" | sort -u | cut -d "-" -f 3 |cut -d "." -f 1-3)

	mkdir -p $tmp_dir
	
	echo -en "Installed version \033[01;32m$installed_verion\033[0m , "

	if [ -z $new_version ]; then
		echo -e "\033[01;32mno updates!\033[0m"
		rm -R $tmp_dir
		exit 0
	else
		echo -e "updating to the version \033[01;32m$new_version\033[0m ..."
	fi

	update_tb=$(curl -s $tb_url | egrep -o -e "thunderbird\-$installed_verion\-[0-9]*\.[0-9]*\.[0-9]*\.partial\.mar" | sort -u)
	wget -O /tmp/tb/out/update.mar $tb_url/$update_tb
	cd $instalation_dir
	cp $instalation_dir/updater $tmp_dir
	$tmp_dir/updater $tmp_dir $instalation_dir $instalation_dir

	rm -R $tmp_dir
}

echo -e "\033[1mFirefox/Thunderbird updater\033[0m"
echo -en "Usage: ff/tb for firefox and thunderbird respectively: "
read choice
case "$choice" in
	"ff") ff ;;
	"tb") tb ;;
	*) exit 0 ;;
esac
