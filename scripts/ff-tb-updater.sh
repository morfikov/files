#!/bin/bash
#
# Last modified: 2015.12.24
# Version: 0.3.1
# Source: https://github.com/morfikov/files/blob/master/scripts/ff-tb-updater.sh
# Author: Mikhail Morfikov <mmorfikov[at]gmail.com>
# Copyright: 2015 Mikhail Morfikov <mmorfikov[at]gmail.com>
# License: GPL-2
#
# This package is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This package is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>
#
# On Debian systems, the complete text of the GNU General
# Public License version 2 can be found in "/usr/share/common-licenses/GPL-2".
#

# See:	https://wiki.mozilla.org/Software_Update:Manually_Installing_a_MAR_file
#		http://download-origin.cdn.mozilla.net/pub/thunderbird/releases/latest/README.txt

user="morfik"
verbose="no"

update() {
	instalation_dir="/opt/$app"
	tmp_dir="/tmp/$app/out"
	language="en-US"
	operating_system="linux64"

	installed_verion="$(su - $user -s /bin/bash -c "$instalation_dir/$app -v 2> /dev/null | egrep -i "$app" | cut -d ' ' -f 3")"
	download_url="https://download.mozilla.org/?product=$app-latest&os=$operating_system&lang=$language"
	file_url="$(curl -s $download_url | egrep -o "http[s]?://[0-9a-zA-Z.\/_\-]*")"

	sha512sums_url="$(echo $file_url | egrep -o "http[s]?://[0-9a-zA-Z.\/_\-]*" | cut -d "/" -f 1-7 | awk '{print $0"/SHA512SUMS"}')"
	sha512sums_asc_url="$(echo $file_url | egrep -o "http[s]?://[0-9a-zA-Z.\/_\-]*" | cut -d "/" -f 1-7 | awk '{print $0"/SHA512SUMS.asc"}')"
	
	update_file_url="$(echo $file_url | egrep -o "http[s]?://[0-9a-zA-Z.\/_\-]*" | cut -d "/" -f 1-7 | awk '{print $0"/update/linux-x86_64/en-US/"}')"
	update_file="$(curl -s $update_file_url | egrep -o -e "$app\-$installed_verion\-[\.0-9]*partial\.mar" | sort -u)"

	new_version="$(echo $update_file | sort -u | cut -d '-' -f 3 |cut -d '.' -f 1-3)"

	if [ $verbose == "yes" ]; then
		echo -e "Variable \$installed_verion: $installed_verion"
		echo -e "Variable \$download_url: $download_url"
		echo -e "Variable \$file_url: $file_url"
		echo -e "Variable \$sha512sums_url: $sha512sums_url"
		echo -e "Variable \$sha512sums_asc_url: $sha512sums_asc_url"
		echo -e "Variable \$update_file_url: $update_file_url"
		echo -e "Variable \$update_file: $update_file"
		echo -e "Variable \$new_version: $new_version"
	fi

	mkdir -p $tmp_dir
	
	echo -en "Installed version \033[01;32m$installed_verion\033[0m, "
	if [ -z "$new_version" ]; then
		echo -e "\033[01;32mno updates!\033[0m"
		rm -R $tmp_dir
		exit 0
	else
		echo -e "updating to the version \033[01;32m$new_version\033[0m ..."
	fi

	if [ $verbose == "yes" ]; then
		wget -O $tmp_dir/SHA512SUMS $sha512sums_url
		wget -O $tmp_dir/SHA512SUMS.asc $sha512sums_asc_url
	else
		wget -q --show-progress -O $tmp_dir/SHA512SUMS $sha512sums_url
		wget -q --show-progress -O $tmp_dir/SHA512SUMS.asc $sha512sums_asc_url
	fi

	echo -en "Running file signature verification..."
	signature_verification="$(gpg --verify $tmp_dir/SHA512SUMS.asc 2>&1)"

	no_key="$(echo "$signature_verification" | egrep "public key not found")"
	if [ ! -z "$no_key" ]; then
		signature_key="$(echo "$signature_verification" | egrep "using RSA key" | cut -d ' ' -f 20)"
		gpg --recv-keys $signature_key > /dev/null 2>&1
		signature_verification="$(gpg --verify $tmp_dir/SHA512SUMS.asc 2>&1)"
	fi

	good_signature="$(echo "$signature_verification" | egrep "Good signature")"
	if [ -z "$good_signature" ]; then
		echo -e "\033[01;31mbad signature\033[0m, file can't be verified, aborting..."
		exit 1
	else
		echo -e "\033[01;32mgood signature\033[0m, file verified!"
	fi

	if [ $verbose == "yes" ]; then
		wget -O $tmp_dir/update.mar $update_file_url$update_file
	else
		wget -q --show-progress -O $tmp_dir/update.mar $update_file_url$update_file
	fi
	
	echo -en "Running checksum... "
	sum_update_file="$(egrep -e "linux-`uname -m`/$language/$update_file" $tmp_dir/SHA512SUMS | egrep -e ".mar$" | cut -d ' ' -f 1)"

	sum_downloaded_update_file="$(sha512sum $tmp_dir/update.mar | cut -d ' ' -f 1)"
	if [ "$sum_update_file" == "$sum_downloaded_update_file" ] ; then
		echo -e "\033[01;32mpassed\033[0m!"
	else
		echo -e "\033[01;31merror\033[0m, file corruption detected, try running this script again!"
		exit 1
	fi

	echo -en "Running update... "
	cd $instalation_dir
	cp $instalation_dir/updater $tmp_dir
	$tmp_dir/updater $tmp_dir $instalation_dir $instalation_dir

	update_status="$(egrep "succeeded" $tmp_dir/update.status)"
	if [ "$update_status" == "succeeded" ]; then
		echo -e "\033[01;32mcomplete\033[0m! You can restart your $app now."
		rm -R $tmp_dir
	else
		echo -e "\033[01;31mSomething went wrong\033[0m, check the $tmp_dir/update.log file for more info."
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
