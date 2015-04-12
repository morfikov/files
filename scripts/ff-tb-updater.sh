#!/bin/bash
#
# Author: Morfik
# Version: 0.1.0
# Date: 2015.04.12
#
# See: https://wiki.mozilla.org/Software_Update:Manually_Installing_a_MAR_file
#

update() {
	instalation_dir="/opt/$app"
	tmp_dir="/tmp/$app/out"
	lang="en-US"

	if [ "$app" == "firefox" ]; then
		installed_verion="$($instalation_dir/$app -v 2> /dev/null | egrep -i "$app" | cut -d ' ' -f 3)"
	elif [ "$app" == "thunderbird" ]; then
		installed_verion="$($instalation_dir/$app -v 2> /dev/null | egrep -i "$app" | cut -d ' ' -f 2)"
	fi

	url="http://download-origin.cdn.mozilla.net/pub/mozilla.org/$app/releases/latest/update/linux-`uname -m`/$lang/"  
	new_version="$(curl -s $url | egrep -o -e "$app\-$installed_verion\-[0-9]*\.[0-9]*\.[0-9]*\.partial\.mar" | sort -u | cut -d '-' -f 3 |cut -d '.' -f 1-3)"
	update_file="$(curl -s $url | egrep -o -e "$app\-$installed_verion\-[0-9]*\.[0-9]*\.[0-9]*\.partial\.mar" | sort -u)"
	signature_file="$(curl -s $url | egrep -o -e "$app\-$installed_verion\-[0-9]*\.[0-9]*\.[0-9]*\.partial\.mar.asc" | sort -u)"
	
	mkdir -p $tmp_dir
	
	echo -en "Installed version \033[01;32m$installed_verion\033[0m, "

	if [ -z "$new_version" ]; then
		echo -e "\033[01;32mno updates!\033[0m"
		rm -R $tmp_dir
		exit 0
	else
		echo -e "updating to the version \033[01;32m$new_version\033[0m ..."
	fi
	
	wget -q --show-progress -O $tmp_dir/update.mar $url/$update_file
	wget -q --show-progress -O $tmp_dir/update.mar.asc $url/$signature_file

	signature_verification="$(gpg --verify $tmp_dir/update.mar.asc 2>&1)"

	no_key="$(echo $signature_verification | egrep "public key not found")"

	if [ ! -z "$no_key" ]; then
		signature_key="$(echo $signature_verification | egrep "using RSA key" | cut -d ' ' -f 21)"
		gpg --recv-keys $signature_key > /dev/null 2>&1
		signature_verification="$(gpg --verify $tmp_dir/update.mar.asc 2>&1)"
	fi

	good_signature="$(echo $signature_verification | egrep "Good signature")"

	if [ -z "$good_signature" ]; then
		echo -e "\033[01;31mBad signature\033[0m, file not verified, aborting..."
		exit 0
	else
		echo -e "\033[01;32mGood signature\033[0m, file verified!"
	fi
	
	cd $instalation_dir
	cp $instalation_dir/updater $tmp_dir
	$tmp_dir/updater $tmp_dir $instalation_dir $instalation_dir

	update_status="$(egrep "succeeded" $tmp_dir/update.status)"

	if [ "$update_status" == "succeeded" ]; then
		echo -e "Update complete! You can restart your $app now."
		rm -R $tmp_dir
	else
		echo -e "Something went wrong, check the $tmp_dir/update.log file for more info."
	fi
}

echo -e "\033[1mFirefox/Thunderbird updater\033[0m"
echo -en "Usage: ff/tb for firefox and thunderbird respectively: "
read choice
case "$choice" in
	"ff") app="firefox" ; update ;;
	"tb") app="thunderbird" ; update ;;
	*) exit 0 ;;
esac
