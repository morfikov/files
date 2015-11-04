#!/bin/bash
#
# Last modified: 2015.11.04
# Version: 0.3.0
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

# For more info see https://wiki.mozilla.org/Software_Update:Manually_Installing_a_MAR_file

user="morfik"

update() {
	instalation_dir="/opt/$app"
	tmp_dir="/tmp/$app/out"
	lang="en-US"

	installed_verion="$(su - $user -s /bin/bash -c "$instalation_dir/$app -v 2> /dev/null | egrep -i "$app" | cut -d ' ' -f 3")"
	url="http://download-origin.cdn.mozilla.net/pub/$app/releases/latest/update/linux-`uname -m`/$lang/"
	sha512sums_url="http://download-origin.cdn.mozilla.net/pub/$app/releases/latest"
	update_file="$(curl -s $url | egrep -o -e "$app\-$installed_verion\-[\.0-9]*partial\.mar" | sort -u)"
	new_version="$(echo $update_file | sort -u | cut -d '-' -f 3 |cut -d '.' -f 1-3)"

	mkdir -p $tmp_dir
	
	echo -en "Installed version \033[01;32m$installed_verion\033[0m, "
	if [ -z "$new_version" ]; then
		echo -e "\033[01;32mno updates!\033[0m"
		rm -R $tmp_dir
		exit 0
	else
		echo -e "updating to the version \033[01;32m$new_version\033[0m ..."
	fi

	wget -q --show-progress -O $tmp_dir/SHA512SUMS $sha512sums_url/SHA512SUMS
	wget -q --show-progress -O $tmp_dir/SHA512SUMS.asc $sha512sums_url/SHA512SUMS.asc

	echo -en "Running file signature verification... "
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

	wget -q --show-progress -O $tmp_dir/update.mar $url$update_file

	echo -en "Running checksum... "
	sum_update_file="$(egrep -e "linux-`uname -m`/$lang/$update_file" $tmp_dir/SHA512SUMS | egrep -e ".mar$" | cut -d ' ' -f 1)"

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
