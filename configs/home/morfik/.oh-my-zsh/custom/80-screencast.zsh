#}}}
#-------- FFMPEG X11GRAB Screencasting {{{
#------------------------------------------------------
# tutorial video: http://www.youtube.com/watch?v=mNz5Lrc06_s
# compile ffmpeg: http://ubuntuforums.org/showthread.php?t=786095
#                 https://ffmpeg.org/trac/ffmpeg/wiki/UbuntuCompilationGuide
# proper screencast: http://ubuntuforums.org/showthread.php?t=1392026
#                    http://nowardev.wordpress.com/2011/05/23/how-to-screencast/
#                    https://github.com/gotbletu/shownotes/blob/master/ffmpeg_x11grab_screencast.txt
#                    https://dl.dropboxusercontent.com/u/28788188/cast.sh (Xpander69)
#                    https://support.google.com/youtube/answer/1722171?hl=en
# credit: verb3k, MocoPoloX, FakeOutdoorsman, Xpander69
# press q to quit

# Screencasting Variables# {{{
# package select (avconv or ffmpeg)
FF_RECORDER=/usr/bin/ffmpeg
#FF_RECORDER=~/Compile/ffmpeg/bin/ffmpeg

# SoundCard (pulse for pulseaudio; install pavucontrol to change pulse settings)
#            hw:0,1 for directly communicating with your soundcard
#            to get a list of sound device:
#            	arecord -l
#            	aplay -l
#            	cat /proc/asound/pcm
#            	alsamixer and hit F6
FF_SOUNDCARD=pulse
# FF_SOUNDCARD=hw:0,1
# FF_SOUNDCARD=hw:2,0
# FF_SOUNDCARD=hw:0,3

# How many threads used (0 for automatic)
FF_THREADS=0

# Resolution (use xrandr to find your resolution or use xwininfo to auto find your resolution)
#FF_RESO_MON1=1680x1050
#FF_RESO_MON2=1920x1080
FF_RESO_FULL=$(xwininfo -root | grep 'geometry' |awk '{print $2;}' | cut -d\+ -f1)
# FF_RESO_ALL=$(xwininfo -root | grep 'geometry' |awk '{print $2;}') #older version

# Xserver Display number(:0.0 is default; use offset for other monitor :0.0+X,Y)
FF_XDISP=:0.0
#FF_XDISP_MON2=:0.0+1680,0

# Audio Device
FF_AUDIO=alsa

# Channels (Mono = 1; Dual = 2 ; dual for most devices)
#FF_CHANNELS=1
FF_CHANNELS=2

# Frames per second
FF_FPS=30

# Constant Rate Factor(0 = highest quality; 50 = lowest)
# CRF=22
FF_CRF=15

# libx264 presets (slow, fast, superfast, ultrafast; run "x264 -h" and go to preset section for more)
# additionaly run "sudo find /usr -iname '*.ffpreset'" for others
FF_PRESET=ultrafast

# Video Codec
FF_VCODEC=libx264

# Compatibility ( yuv444p for H.264, yuv420p for compatibility with outdated media players )
FF_PIXFMT=yuv444p

# Audio Codec (libmp3lame, pcm_s16le or libvorbis are most common)
# ACODEC=libvorbis
# ACODEC=pcm_s16le
FF_ACODEC=libmp3lame

# Directory where your video is gonna be saved.(include / at the end)
# DIRECTORY=$HOME/Public/
FF_DIRECTORY=$PATH_SCREENCAST/

# File name
FF_FILENAME=videocast_`date +%Y-%m-%d_%H.%M.%S`.mkv

# ======== OPTIONAL ========
# Scale Video on the fly
# I use this for youtube since my Monitor is 1680x1050 and Youtube 720p video is 1280x720; so i
# scale down the resolution
# This avoids black bars on left and right side (non-fullscreen); on "fullscreen" the black bars
# are on top and bottom orginal flag: -vf scale=1280:720
#FF_SCALE="scale=1280:720"

# Overwrite Output File; ( -y = yes ; -n = no )
# This only works if you use the same filename
#FF_OVERWRITE="-y"
# ==========================
# }}}

# Screencasting Commands# {{{
# Monitor 1 = Benq LCD with Scaling 1680x1050 --> 1280x720 Youtube 720p
#ffcast_benq() { $FF_RECORDER -f $FF_AUDIO -ac $FF_CHANNELS -i $FF_SOUNDCARD -async 1 -f x11grab -r $FF_FPS -s $FF_RESO_MON1 -i $FF_XDISP -vcodec $FF_VCODEC -pix_fmt $FF_PIXFMT -preset $FF_PRESET -crf $FF_CRF -acodec $FF_ACODEC -ab 128k -threads $FF_THREADS -vf $FF_SCALE $FF_OVERWRITE $FF_DIRECTORY$FF_FILENAME ;}

# Monitor 2 = Proscan LED TV; 1080p - 1920x1080
#ffcast_proscantv() { $FF_RECORDER -f $FF_AUDIO -ac $FF_CHANNELS -i $FF_SOUNDCARD -async 1 -f x11grab -r $FF_FPS -s $FF_RESO_MON2 -i $FF_XDISP_MON2 -vcodec $FF_VCODEC -pix_fmt $FF_PIXFMT -preset $FF_PRESET -crf $FF_CRF -acodec $FF_ACODEC -ab 128k -threads $FF_THREADS $FF_OVERWRITE $FF_DIRECTORY$FF_FILENAME ;}

# fullscreen
ffcast_full() { $FF_RECORDER -f $FF_AUDIO -ac $FF_CHANNELS -i $FF_SOUNDCARD -async 1 -f x11grab -r $FF_FPS -s $FF_RESO_FULL -i $FF_XDISP -vcodec $FF_VCODEC -pix_fmt $FF_PIXFMT -preset $FF_PRESET -crf $FF_CRF -acodec $FF_ACODEC -ab 128k -threads $FF_THREADS $FF_OVERWRITE $FF_DIRECTORY$FF_FILENAME ;}
# }}}

# ------ old examples ------# {{{
#E1: ffmpeg -f alsa -ac 2 -i hw:0,1 -f x11grab -r 30 -s 1280x1024 -i :0.0 -acodec pcm_s16le -vcodec libx264 -vpre lossless_ultrafast -threads 0 out.avi
#E2: avconv -f alsa -i pulse -f x11grab -r 25 -s 1920x1080 -i :0.0 -vcodec mpeg4 -b 12000k -g 300 -bf 2 -acodec libmp3lame -ab 256k out.avi
#E3: ffmpeg -threads 0 -f alsa -i pulse -f x11grab -s 1280x720 -r 30 -i :0.0+0,0 -vcodec libx264 -preset superfast -crf 16 -acodec libmp3lame -ab 256k -ar 44100 -f mp4 out.mp4
#E4: ffmpeg -f alsa -ac 2 -i hw:0,0 -f x11grab -r 30 -s $(xwininfo -root | grep 'geometry' | awk '{print $2;}') -i :0.0 -acodec pcm_s16le -vcodec libx264 -preset ultrafast -crf 0 -threads 0 -y out.mkv
#E5: (select window); ffmpeg -f alsa -ac 2 -i hw:0,0 -f x11grab -r 30 -s $(xwininfo -frame | grep -oEe 'geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+') -i :0.0+$(xwininfo -frame | grep -oEe 'Corners:\s+\+[0-9]+\+[0-9]+' | grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/\+/,/' ) -acodec pcm_s16le -vcodec libx264 -preset ultrafast -crf 0 -threads 0 -y out.mkv
#E6: ffmpeg -f alsa -ac 2 -i hw:3,0 -async 1 -f x11grab -r 30 -s 1280x1024 -i :0.0 -vcodec libx264 -pix_fmt yuv444p -preset ultrafast -crf 0 -acodec libmp3lame -ab 128k -threads 0 -vf 800x600 -y out.mkv ;}
# --------------------------# }}}
