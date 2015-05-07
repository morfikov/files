# }}}
#-------- PulseAudio Switcher CLI {{{
#------------------------------------------------------
# tutorial video: https://www.youtube.com/watch?v=jhv-2pNWfr4

pa-list() { pacmd list-sinks | awk '/index/ || /name:/' ;}

pa-set() { 
	# list all apps in playback tab (ex: cmus, mplayer, vlc)
	inputs=($(pacmd list-sink-inputs | awk '/index/ {print $2}')) 
	# set the default output device
	pacmd set-default-sink $1 &> /dev/null
	# apply the changes to all running apps to use the new output device
	for i in ${inputs[*]}; do pacmd move-sink-input $i $1 &> /dev/null; done
}

pa-playbacklist() { 
	# list individual apps
	echo "==============="
	echo "Running Apps"
	pacmd list-sink-inputs | awk '/index/ || /application.name /'

	# list all sound device
	echo "==============="
	echo "Sound Devices"
	pacmd list-sinks | awk '/index/ || /name:/'
}

pa-playbackset() { 
	# set the default output device
	pacmd set-default-sink "$2" &> /dev/null
	# apply changes to one running app to use the new output device
	pacmd move-sink-input "$1" "$2" &> /dev/null
}

# http://askubuntu.com/a/18210
pa-swap() { /opt/skrypty/pulseaudio_toggle.sh ;}

#}}}
#-------- FZF {{{
#------------------------------------------------------
fzf-locate() { xdg-open "$(locate "*" | fzf -e)" > /dev/null 2>&1 ;}
bindkey -s '^\' "fzf-locate\n"

fzf_killps() { zle -I; ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9} ; }; zle -N fzf_killps;
bindkey -s '^Q' "fzf_killps\n"
#}}}

#-------- Configurations {{{
#------------------------------------------------------
cfg-bash-bashrc() { $EDITOR ~/.bashrc ;}
cfg-zsh-zshrc() { $EDITOR ~/.zshrc ;}
cfg-zsh-config() { $EDITOR ~/.oh-my-zsh/custom/10-config.zsh ;}
cfg-zsh-vars() { $EDITOR ~/.oh-my-zsh/custom/20-vars.zsh ;}
cfg-zsh-aliases() { $EDITOR ~/.oh-my-zsh/custom/50-aliases ;}
cfg-openbox-autostart() { $EDITOR ~/.config/openbox/autostart ;}
cfg-openbox-environment() { $EDITOR ~/.config/openbox/environment ;}
cfg-openbox-menu() { $EDITOR ~/.config/openbox/menu.xml ;}
cfg-openbox-rc() { $EDITOR ~/.config/openbox/rc.xml ;}
cfg-conky-conkyrc() { $EDITOR ~/.conky/.conkyrc ;}
cfg-conky-conkyrc_fs() { $EDITOR ~/.conky/.conkyrc_fs ;}
cfg-conky-conkyrc_1b1() { $EDITOR ~/.conky/1b1/.conkyrc_1b1_int ;}
cfg-conky-conkyrc_1c() { $EDITOR ~/.conky/1c/.conkyrc_1c ;}
cfg-newsbeuter() { $EDITOR  ~/.config/newsbeuter/config ;}
cfg-newsbeuter-urls() { $EDITOR ~/.config/newsbeuter/urls ;}
cfg-plowdown-add-url() { $EDITOR ~/.config/plowshare/random.txt }
cfg-xresources() { $EDITOR ~/.config/Xresources/.Xresources ;}
cfg-xresources-colors() { $EDITOR ~/.config/Xresources/.Xresources ;}
cfg-xresources-fonts() { $EDITOR ~/.config/Xresources/.Xresources ;}
cfg-xresources-urxvt() { $EDITOR ~/.config/Xresources/.Xresources ;}

cfg-xsession() { $EDITOR /etc/X11/Xsession ;}
cfg-xsession-options() { $EDITOR /etc/X11/Xsession.options ;}
cfg-xinitrc() { $EDITOR /etc/X11/xinit/xinitrc ;}
cfg-xserverrc() { $EDITOR /etc/X11/xinit/xserverrc ;}
cfg-dircolors() { $EDITOR /etc/DIR_COLORS ;}
cfg-fstab() { $EDITOR /etc/fstab ;}
cfg-crypttab() { $EDITOR /etc/crypttab ;}
cfg-interfaces() { $EDITOR /etc/network/interfaces ;}
cfg-wpa-supplicant() { $EDITOR /etc/wpa_supplicant/wpa_supplicant.conf ;}
cfg-password() { $EDITOR /etc/password ;}
cfg-shadow() { $EDITOR /etc/shadow ;}
cfg-group() { $EDITOR /etc/group ;}
cfg-hosts() { $EDITOR /etc/hosts ;}
cfg-lightdm() { $EDITOR /etc/lightdm/lightdm.conf ;}
cfg-tmuxrc() { $EDITOR /etc/tmux.conf ;}
cfg-vimrc() { $EDITOR /etc/vim/vimrc ;}
cfg-wgetrc() { $EDITOR /etc/wgetrc ;}
cfg-pyradio() { $EDITOR /opt/skrypty/pyradio-0.4/stations.csv ;}

edit-hints() { $EDITOR  ~/.oh-my-zsh/custom/80-hints.zsh ;}
#}}}
#-------- Configurations Reload {{{
#------------------------------------------------------
reload-bashrc() { source ~/.bashrc ;}
reload-zshrc() { source ~/.zshrc ;}
reload-xresources() { xrdb -load ~/.config/Xresources/.Xresources ;}
reload-conky() {
	killall -9 conky && sleep 1
	~/.conky/autostart_conky > /dev/null 2>&1
}
reload-tint2() {
	killall -9 tint2 && sleep 1
	tint2 -c /home/morfik/.config/tint2/tint2rc_up > /dev/null 2>&1 & ; disown
	tint2 -c /home/morfik/.config/tint2/tint2rc_down > /dev/null 2>&1 & ; disown
}

#}}}
#-------- Common Aliases {{{
#------------------------------------------------------
# enable color support for common commands
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	ls_opt=' --color=auto '
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

ls_opt+=' --classify --human-readable --all --group-directories-first --time-style="+%Y-%m-%d %H:%M:%S" '
alias ls="ls $ls_opt"

# list and grep
lsg() {
	keyword=$(echo "$@" |  sed 's/ /.*/g')
	ls -ltr  | grep -iE $keyword
}

alias psc='ps xawf -eo pid,user,cgroup,args'
alias mpd='mpd ~/.config/mpd/mpd.conf'
alias gcp='gcp -rvf'
alias su='su -'
alias dmesg='dmesg -T'
#alias cp='cp -i'				# cp interactive
#alias mv='mv -i'				# mv interactive
#alias rm='rm -i'				# rm interactive
alias df='df -hT'				# human readable, print filetype
alias dfc='dfc -T'				# print filetype
alias du='du -d1 -h'			# max depth, human readable
alias free='free -ht'			# human readable, print total
alias lsblk='lsblk -o "NAME,SIZE,FSTYPE,TYPE,LABEL,MOUNTPOINT,UUID"'    # combo use lsblk or lsblk -f
alias mkdir='mkdir -p -v'		# create if not exist, verbose
#alias mount='mount | column -t'			# align in column
alias nano='nano -c -$'			# word wrapping
alias wget='wget -c'			# continues/resumes

# }}}
#-------- Other Stuff {{{
#------------------------------------------------------
# searches for manual online
manned() { for arg in "$@"; do $BROWSER "http://manpages.ubuntu.com/cgi-bin/search.py?q=$@" 2> /dev/null ; done ;}

# python calculator
# press Ctrl+D to quit
# http://docs.python.org/library/math.html
# tutorial video: http://www.youtube.com/watch?v=JkyodHenTuc
calc() { python2 -ic "from __future__ import division; from math import *; from random import *" ;}

# display one random command from commandlinefu.com
cmdfu-random() { echo -e "`curl -sL http://www.commandlinefu.com/commands/random/json|sed -re 's/.*,"command":"(.*)","summary":"([^"]+).*/\\x1b[1;32m\2\\n\\n\\x1b[1;33m\1\\x1b[0m/g'`\n" ;}

# check if a website is down
# usage: down4me google.com
down4me() { curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g';}

# mplayer to display webcam; hit 's' to take screenshot
# https://wiki.archlinux.org/index.php/Webcam_Setup#MPlayer
# http://www.amazon.com/Logitech-960-000581-C260-Webcam/dp/B003LVZO8I
# 16:9 ; 1280x720 ; 3MP picture; 
webcam-mplayer() { mplayer tv:// -tv driver=v4l2:width=1280:height=720:device=/dev/video0 -fps 30 -vf screenshot ;}

# tutorial video: http://www.youtube.com/watch?v=5AzFdX-EyeI
# d/l cyberlocker files like rapidshare, mediafire ..etc
# http://code.google.com/p/plowshare/
plowdown-random() { plowdown -r 3 --max-rate 1M -m ~/.config/plowshare/random.txt ;}

# combine multiple avi files into a single avi file
# tutorial video: https://www.youtube.com/watch?v=EAWGFJoZXAU
combine-avi() { avimerge -o combineavi_`date +'%F_%Hh%M'`.avi -i "$@" ;}

# convert video to avi container
# usage: vid2avi file.mpg
vid2avi() { ffmpeg -i "$1" -vcodec mpeg4 -sameq "${1%.*}.vid2avi.avi" ;}

# http://www.youtube.com/watch?v=rE7ISiKoNec
web2png() { cutycapt --url="$1" --out=web2png_output.png ;}

info-current-ip-address() { echo Current IP $(dig +short myip.opendns.com @resolver1.opendns.com) ; }
info-sound() { cat /proc/asound/pcm && arecord -l ;} #List audio capture card
info-distro() { uname -a && lsb_release -a ;}

# find files
@find() { 
        keyword=$(echo "*$@*" |  sed -e 's/ /*/g')
	find /home /media -type f -iname $keyword | vim -R - ;}

# find starting at current dir and go recursively to sub dir
@search() { 
        keyword=$(echo "*$@*" |  sed -e 's/ /*/g')
	find -type f -iname $keyword | vim -R - ;}

# find current dir files bigger than X size
# useage: @size <filesize> <keyword>
@size() { 
	keyword=$(echo "*${@:2}*" |  sed -e 's/ /*/g')
	find -type f -size +${1}M -iname $keyword  | vim -R - ;} 

# search pdf files in current dir for keywords inside the pdfs
# http://www.commandlinefu.com/commands/view/9189
@pdfgrep() { find -iname \*.pdf -print0 | xargs -0 pdfgrep -in "$@" ;}

# take screenshot fullscreen, single window or draw a box
pix() { import -pause 2 -window root "$PATH_SCREENSHOT/fullscr_`date +'%F_%Hh%Ms%S'`.png" ; }
pix-area() { import -pause 2 "$PATH_SCREENSHOT/windowed_`date +'%F_%Hh%Ms%S'`.png" ;}
pix-window() { import -pause 2 -frame -strip -quality 85 "$PATH_SCREENSHOT/pscreen-win_`date +'%F_%Hh%M'`.png" ;}

say() { 
	# limit to 100 character or less
	# language code: http://developers.google.com/translate/v2/using_rest#language-params
	# useage: say <language code> <phase>
	# example: say es come with me
	mplayer -user-agent Mozilla \
	"http://translate.google.com/translate_tts?ie=UTF-8&tl="$1"&q=$(echo "$@" \
	| cut -d ' ' -f2- | sed 's/ /\+/g')" > /dev/null 2>&1 ;}

# http://madebynathan.com/2011/08/16/bash-color-index/
# display color
color-index() { /opt/skrypty/color-index.sh ;}
color-test() { /opt/skrypty/color-test.sh ;}
color-256() { /opt/skrypty/color-256.sh -w -s ;}

# https://bbs.archlinux.org/viewtopic.php?pid=658127#p658127
# show color for tput
color-tput() { /opt/skrypty/color-tput.sh ;}

# http://www.gentoo-wiki.info/TIP_Make_a_Screenshot_with_PrintScreen_Key
# take screenshot fullscreen, window, area selection using import command
#sshot() { /opt/skrypty/screenshot.sh area ;}

# http://sourceforge.net/projects/torrtux/
# search magnet links from thepiratebay
#torrtux-dev() { ~/.binary/torrtux-0.0.3/torrtux ;}

# http://www.webupd8.org/2013/01/enable-trim-on-ssd-solid-state-drives.html
trim-check() {
#	hdparm -I /dev/sda | grep "TRIM supported"
	hdparm -I /dev/"$1" | awk '/.*TRIM supported.*/{ if ($1 == "*") print "Yes, TRIM is enabled"; else print "No, TRIM is not enabled." ;}'
}
trim-fstrim() { sudo fstrim -v "$1" ;}

# http://www.falsyana.com/2010/linux/cp-mv-with-a-progress-bar/
# http://unix.stackexchange.com/questions/2577/move-files-with-progress-bar
# slower then regular mv or cp
#alias cp='rsync --progress -ah'
#alias mv='rsync --progress -ah --remove-sent-files'

zombie-process() { ps aux | awk '{ print $8 " " $2 }' | grep -w Z ;}

iso-mount() {
	DIR=/media/morfik/iso
	udevil mount "$1" "$DIR"
}
iso-unmount() {
	DIR=/media/morfik/iso
	udevil umount "$DIR"
}

# imgur album downloader
# https://github.com/alexgisby/imgur-album-downloader
# tutorial video: https://www.youtube.com/watch?v=dW4co9f5Ors
imguralbum() { python3 /opt/skrypty/imguralbum.py "$@" ;}

wget-ext-url() { 
	# download all extension on a webpage
	# http://stackoverflow.com/a/18709707
	# -r            recursive
	# -l1           maximum recursion depth (1=use only this directory)
	# -H            span hosts (visit other hosts in the recursion)
	# -t1           Number of retries
	# -nd           Don't make new directories, put downloaded files in this one
	# -N            turn on timestamping
	# -A.mp3        download only mp3s
	# -erobots=off  execute "robots.off" as if it were a part of .wgetrc
	wget -r -l1 -H -t1 -nd -N -np -A "$1" -erobots=off "$2"
}
