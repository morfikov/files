# Set display
export DISPLAY=:0.0

# Find alternative apps if it is installed on your system
find_alt() { for i;do which "$i" >/dev/null && { echo "$i"; return 0;};done;return 1; }

# Use the first program that it detects in the array as the default app
export OPENER=$(find_alt xdg-open exo-open gnome-open )
export BROWSER=$(find_alt firefox chromium chromium-browser google-chrome $OPENER )
export EDITOR=$(find_alt vim emacs nano leafpad gedit pluma $OPENER )
export FILEMANAGER=$(find_alt spacefm pcmanfm thunar nautilus dolphin enlightenment_filemanager $OPENER )
export PAGER=$(find_alt less more most)
export PATH_SCREENCAST="/home/morfik/Desktop/"
export PATH_SCREENSHOT="/home/morfik/skriny"

# mysql-workbench
export GNOME_KEYRING_CONTROL=$(ls -d /run/user/`id -u`/keyring | head -n 1)

# wallpaper path
PATH_WALLPAPER=~/wallpapers

# http://askubuntu.com/questions/49784/how-is-bin-added-to-my-path
# Set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/.local/bin" ] ; then
#	PATH="$HOME/.local/bin:$PATH"
#fi

# Debian maintainer
export DEBEMAIL="mmorfikov@gmail.com"
export DEBFULLNAME="Mikhail Morfikov"

# Force XFT
export GDK_USE_XFT="1"
export QT_XFT="true"

# Color the manpages
# Tutorial video: http://www.youtube.com/watch?v=9BFaLAa428k
export LESS_TERMCAP_mb=$'\E[01;31m'             # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'             # begin bold
export LESS_TERMCAP_me=$'\E[0m'                 # end mode
export LESS_TERMCAP_se=$'\E[0m'                 # end standout-mode                 
export LESS_TERMCAP_so=$'\E[01;44;33m'          # begin standout-mode - info box 
export LESS_TERMCAP_ue=$'\E[0m'                 # end underline
export LESS_TERMCAP_us=$'\E[01;32m'             # begin underline

# Color the manpages (alternative)
#export MANPAGER="/usr/bin/most -s"             # color using most

# Color for grep
# http://linuxaria.com/pills/coloring-grep-to-easier-research
#	Color	Foreground	Background
#	Black	    30	      40
#	Red	        31	      41
#	Green	    32	      42
#	Yellow	    33	      43
#	Blue	    34	      44
#	Magenta	    35	      45
#	Cyan	    36	      46
#	White	    37	      47
export GREP_COLOR='1;32'

#if [ "$PS1" ]; then
    # Setup information required by GnuPG and ssh.  We use the
    # standard socket in GnuPG's homedir, thus there is no need for an
    # environment variable.  We reset any left over envvar.
    # SSH_AGENT_PID should not be set because it is only used
    # to kill ssh-agent (option -k) but we don't want this to kill
    # gpg-agent.  Because ssh does not know about GnuPG's homedir we
    # need to set its envvar to the standard of gpg-agent.  GPG_TTY needs
    # to be set to the current TTY.  The extra test is used to avoid
    # setting SSH_AUTH_SOCK if gpg-agent has been started with the
    # shell on the command line (often used for testing).
#    unset GPG_AGENT_INFO
#    unset SSH_AGENT_PID
#    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#      export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
#    fi
#fi
#export GPG_TTY=`tty`
