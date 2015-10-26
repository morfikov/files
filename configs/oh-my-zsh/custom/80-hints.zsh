# }}}
hint-vim-folding() {
echo -e "
Vim folding commands
au BufWinLeave * mkview
au BufWinEnter * silent loadview

{visual mode} zf
zf#j creates a fold from the cursor down # lines.
zf/string creates a fold from the cursor to string .
za When on a closed fold, open it.and vice-versa.
zA When on a closed fold, open it recursively.and vice-versa
zj moves the cursor to the next fold.
zk moves the cursor to the previous fold.
zo opens a fold at the cursor.
zO opens all folds at the cursor.
zm increases the foldlevel by one.
zM closes all open folds.
zr decreases the foldlevel by one.
zR decreases the foldlevel to zero -- all folds will be open.
zd deletes the fold at the cursor.
zE deletes all folds.
[z move to start of open fold.
]z move to end of open fold.
" | less
}

# }}}
hint-vim-search-replace() {
echo -e "
:s/foo/bar/g		 Change each 'foo' to 'bar' in the current line.
:%s/foo/bar/g		 Change each 'foo' to 'bar' in all lines.
:5,12s/foo/bar/g	 Change each 'foo' to 'bar' for all lines from line 5 to line 12 inclusive.
:'a,'bs/foo/bar/g	 Change each 'foo' to 'bar' for all lines from mark a to mark b inclusive.
:.,$s/foo/bar/g		 Change each 'foo' to 'bar' for all lines from the current line (.)
						to the last line ($) inclusive.
:.,+2s/foo/bar/g	 Change each 'foo' to 'bar' for the current line (.) and the two next lines (+2).
:%s/foo/bar/g		 Equivalent to :1,$s/foo/bar/g (change all lines).
:g/^baz/s/foo/bar/g	 Change each 'foo' to 'bar' in each line starting with 'baz'.

/copyright oppositeslashC   	Case sensitive
/Copyright oppositeslashc     	Case insensitive
daw			delete the word under the cursor    
caw			delete the word under the cursor and put you in insert mode
diSYMBOL		delete between qoutes; or other symbols; like brackets, single qoutes ..etc
ciSYMBOL
dtSYMBOL		delete until charator
dTSYMBOL		delete until charator; backwards"
}

# }}}
hint-vim-pane() {
echo -e "
Master key: Ctrl+W
:vsplit		:vs	v		split vertical
:split		:sp	s		split horizontal
hjkl					move between panes
q					kill a pane
:ls					show open buffer
:b [number]				open buffer with number
" | less
}

hint-vim-hotkey() {
echo -e "
Hotkeys
--------------------
/^fred.*joe.*bill  : line beginning with fred, followed by joe then bill
/^[A-J]            : line beginning A-J
/^[A-J][a-z]\+\s   : line beginning A-J then one or more lowercase characters then space or tab
/fred\_.\{-}joe    : fred then anything then joe (over multiple lines)
/fred\_s\{-}joe    : fred then any whitespace (including newlines) then joe
/fred\|joe         : fred OR joe
#G              Go to line
C-r             redo

Navigate
C-F, C-D	pagedown
C-B, C-U	pageup
f,F	move to 1st occurance of that letter, leftwards
 : or ,		move to next or previous, using f or F

Copy / Pasting
mx then y'x     	# copy mutli lines
mx then d'x     	# cut multi lines
yw              	# copy until end of single word
y$              	# copy until end of single line
C-v,jj,I,text,Esc	#Visual Block insert front of liness
C-v,jj,$,A,text,Esc	#Visual Block append end of line

C-v,jj,x,Esc		#Visual Block delete from liness
c		change
ct<letter>	change until letter
s, S		delete char then go into insertmode, delete line then insertmode
Repeat
j.
o, O 		insert new line below, above	
c, C		change line go into insert mode
\"+y or 5\"+y	copy to x clipboard (can be used in visual mode also
" | less
}
# }}}

hint-shell-hotkey() {
echo -e "
 ZSH:
  Alt + b   Move cursor backward one word on the current line
  Alt + f   Move cursor forward one word on the current line
  Ctrl + c  Copy
  Ctrl + d  Exit the current shell
  Ctrl + e  Go to the end of the line you are currently typing on
  Ctrl + h  Same as backspace
  Ctrl + k  Clear the line after the cursor
  Ctrl + l  Clears the Screen, similar to the clear command
  Ctrl + r  Let’s you search through previously used commands
  Ctrl + t  Swap the last two characters before the cursor
  Ctrl + u  Clears the line before the cursor position. If you are at the end of the line, clears the entire line.
  Ctrl + v  Paste
  Ctrl + w  Delete the word before the cursor
  Ctrl + z  Puts whatever you are running into a suspended background process. fg restores it.
  Ctrl + Shift + c  Kill whatever you are running
  Esc + t   Swap the last two words before the cursor
  Tab       Auto-complete files and folder names
 TMUX:
  Alt + k  prev pane
  Alt + j  next pane
  Alt + h  previous window
  Alt + l  next window
  Ctrl + A  Tmux prefix
    >  resize pane (right)
    <  resize pane (left)
    +  resize pane (up)
    =  resize pane (down)
    -  split-window (horizontally)  
    |  split-window (vertically)
    q  kill pane
    Q  kill window
    k  clear history (buffer)
    m  enable mouse
    M  disable mouse
    d  detach client
    D  choose client to detach
    '  choose window
    \"  choose session
    w  display visible indicator of each pane
    Ctrl + p  copy buffer to a file
    b  list buffers
    p  choose buffer
    x  delete buffer
    n  new window
    space  next window
    backspace  previous window
    A  rename window
    \  kill tmux server
    *  list clients
    s toggle status bar
" | less
}
# }}}

hint-git() {
echo -e "
Loginto Github make new repo then

Global setup:
  git config --global user.name \"Mikhail Morfikov\"
  git config --global user.email morfik@nsa.com
  git config --global gpg.program gpg
  git config --global user.signingkey 0x72F3A416B820057A
  git config --global push.default simple
  git config --global color.ui always
  git config --global core.whitespace blank-at-eol,blank-at-eof,space-before-tab,tabwidth=4
  git config --global merge.tool meld
  git config --global diff.tool meld
  git config --global core.editor vim
  git config --global core.pager less
  git config --global core.excludesfile ~/.config/git/.gitignore_global
  git config --global core.ignorecase false
  git config --global core.eol lf
  git config --global core.autocrlf input
  git config --global web.browser firefox
  git config --global browser.firefox.path /opt/firefox/firefox
  git config --global browser.firefox.cmd 'firefox -P default'
  git config --global log.date iso8601
  git config --global log.decorate full
 Config check:
  git config -l

New repo:
  mkdir dotfiles
  cd dotfiles
  git init
  touch README
  git add README    or    git add \*    or    git add .
  git status -s    check file status 
  git diff --cached
  git commit -S -m 'first commit'
  git remote add origin https://github.com/morfikov/practice-makes-perfect.git    (for https)
  git remote add origin git@github.com:morfikov/practice-makes-perfect.git    (for ssh)
  git push -u origin master    (--set-upstream)

Remotes:
  git remote add upstream git://github.com/paulboone/ticgit.git
  git remote rename upstream paul
  git remote rm paul
  git remote -v
  git fetch pull upstream master
  git fetch upstream master
  git remote show origin

Change https <=> ssh
  git remote set-url origin git@github.com:morfikov/conffiles.git
  git remote set-url origin https://github.com/morfikov/conffiles.git
  
Logs:
  git log -p
  git log -1
  git log --since=2.weeks --until=now
  git log --since=yesterday --until=\"2015-02-17 12:22:00\"
  git log --author=morfik
  git log --stat
  git log --pretty=format:\"%H - %an, %ad : %s\"
  git log --pretty=format:\"%h on %ad by %an (%G? 0x%GK): %s%d\" --graph --date=short
  git log --tags --show-notes --simplify-by-decoration --pretty=\"format:%ai %d %s (%G? 0x%GK)\" 
  git log --oneline

Changes:
  git reset --soft HEAD test_file    (unstage this file)
  git log --format=oneline    (in order to get hash)
  git reset --soft HEAD~1    (revert changes, one commit)
  git revert 49f8b65ed0d2ae0c7f17fd0003af832f61c7885a
  git commit --amend -S -m 'new message'	(Rename the last comment message)

Rename comments:
  git rebase -i HEAD~7    (Displays a list of the last 7 commits on the
                          current branch)
  git push --force

Diffs:
git diff			show differences between your working directory and the index
git diff -–cached 	show differences between the index and the most recent commit
git diff HEAD 		show the differences between your working directory and the most recent commit

Commits:
git commit -S -m "some text"	create and sign a commit

==================
https://help.github.com/articles/set-up-git
https://help.github.com/articles/generating-ssh-keys
http://git-scm.com/book/en/v2/Getting-Started-About-Version-Control
https://www.kernel.org/pub/software/scm/git/docs/
" | less
}
# }}}

hint-dollarsign() {
echo -e "
http://linuxsig.org/files/bash_scripting.html
\$#	Stores the number of command-line arguments that were passed to the shell program.
\$_	Stores the last input
\$?	Stores the exit value of the last command that was executed.
\$0	Stores the first word of the entered command (the name of the shell program).
\$*	Stores all the arguments that were entered on the command line ($1 $2 ...).
\"\$@\"	Stores all the arguments that were entered on the command line, individually quoted (\"\$1\" \"\$2\" ...).
" | less
}
# }}}

hint-hardware-info() {
echo -e " 
dmidecode                   ram, bios, cpu, sys, bat, board info
ethtool eth1                wire network interfaces
iw list                     wireless network interfaces
decode-dimms (i3c-tool)     ram
lshw                        everything, see --help for info
hwinfo                      everything, see --help for info
rfkill list                 wifi, bluetooth devices
update-pciids               utility to download the most recent version of a
                             list (/usr/share/misc/pci.ids) of all known PCI
                             ID's (vendors, devices, classes and subclasses)
lspci                       list all pci devices
  -vvv                      very verbose
  -kk                       kernel drivers
  -nn                       show both textual and numeric ID's (names & numbers)
lsusb                       list usb devices
  -vvv                      very verbose
  -t                        physical usb device hierarchy
lsusb -v | grep -E '\<(Bus|iProduct|bDeviceClass|bDeviceProtocol)' 2>/dev/null
tree /dev/                  list /dev/ directory
lsmod                       list loaded modules 
dmesq                       display kernel messages
dmesg | egrep '
  acx|at76|ath|b43|bcm|brcm|CX|eth|ipw|ireless|irmware|isl|lbtf|orinoco|
  ndiswrapper|NPE|ound|p54|prism|rtl|rt2|rt3|rt5|rt6|rt7|usb|witch|wl'
dmesg -t | grep -i 'error\|warn\|exception'
sensors-detect              detect hardware monitoring chips
sensors                     ąnd display them
smartctl --all /dev/sda     disk smart raport
/proc/asound/card0/codec#   sound card codecs
/proc/sys/dev/cdrom/info    cd/dvd info
/proc/cpuinfo (lscpu)   cpu info
xrandr --verbose            screen info
v4l2-ctl --list-devices     webcam info
v4l2-ctl --list-formats-ex
v4l2-ctl -L                 webcam attributes (can be customized)


==================
http://www.ideasonboard.org/uvc/
https://wikidevi.com/wiki/Atheros
http://www.linux-usb.org/usb.ids
http://www.pcidatabase.com/index.php
" | less
}

# }}}
hint-ffmpeg() {
echo -e "
cut 5min from a movie starting from 05:00:000 and recompress it:

        ffmpeg -i file.avi -ss 00:05:00.000 -to 00:10:00.000 \
        -vcodec libx264 -acodec libvo_aacenc -o file_cut.avi

cut 30secs from a movie starting from 5min and recompress it:

        ffmpeg -i file.avi -ss 5:00 -t 30 \
        -vcodec libx264 -acodec libvo_aacenc -o file_cut.avi

save one frame as .png file:

        fmpeg -i file.avi -ss 00:10:00 -frames:v 1 file.png

cut 5min of a movie without recompression:
        ffmpeg -i file.mp4 -vcodec copy -acodec copy \
        -ss 00:05:00 -to 00:10:00 file_cut.mp4
        
Two pass encoding:
	bitrate = file size / duration
	(50 MB * 8192 [converts MB to kilobits]) / 600 seconds =
	~683 kilobits/s total bitrate 683k - 128k (desired audio
	bitrate) = 555k video bitrate

		ffmpeg -y -i input -c:v libx264 -preset medium -b:v 555k \
		-pass 1 -c:a libfdk_aac -b:a 128k -f mp4 /dev/null && \
		
		ffmpeg -i input -c:v libx264 -preset medium -b:v 555k \
		-pass 2 -c:a libfdk_aac -b:a 128k output.mp4


https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
https://trac.ffmpeg.org/wiki/Capture/Desktop
https://trac.ffmpeg.org/wiki/Seeking
" | less
}
