#}}}
#-------- Capture RTMP Streams {{{
#------------------------------------------------------
# tutorial video: http://www.youtube.com/watch?v=u1dQ81HT4AU
# http://forum.wiziwig.eu/threads/41036-Help-yourself-to-Help-me-find-streaming-URL-s
# http://forum.wiziwig.eu/threads/56033-RTMPDump-Q-A-s
# http://pclosmag.com/html/Issues/201104/page19.html
# http://www.pclinuxos.com/forum/index.php?topic=87138.0
# redirect, then use srv or suck, then undo
sniff-begin() { sudo iptables -t nat -A OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT ;}
sniff-capture-rtmpsrv() { rtmpsrv ;}
sniff-capture-rtmpsuck() { rtmpsuck ;}
sniff-end() { sudo iptables -t nat -D OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT ;}
tsniff-begin() { sudo tcpdump -ieth0 -nn -A | grep -e"rtmp" -e"connect" -e"play" > /tmp/tcpoutput.txt ;}
tsniff-less() { less /tmp/tcpoutput.txt ;}

#}}}
#-------- Internet Videos
# http://www.ilive.to/channels
# http://castalba.tv/channels
# http://www.giddyupnetwork.info/pages/live-shows-movies
# http://database.freetuxtv.net/WebStream/
# http://pclosmag.com/html/Issues/201104/page19.html
# http://growing-flower-3635.herokuapp.com/
#
# https://www.youtube.com/user/aljazeeraenglish
# http://www.aljazeera.com/watch_now/


tv-stream-news-aljazeera() { rtmpdump -v -r "rtmp://aljazeeraflashlivefs.fplive.net/aljazeeraflashlive-live" -a "aljazeeraflashlive-live" -f "LNX 11,2,202,261" -W "http://static.castalba.tv/player.swf" -p "http://castalba.tv/channel/4182" -y "aljazeera_eng_low" | "mplayer" - ;}
tv-stream-news-pentagon() { rtmpdump -v -r "rtmp://cp114761.live.edgefcs.net:443/live/" -y "tpc-live_1@44263" -W "http://www.pentagonchannel.mil/swf/flvplayer.swf" -p "http://www.pentagonchannel.mil/library.html" | "mplayer" - ;}
tv-stream-tech-thisweekintech() { "mplayer" "http://bglive-a.bitgravity.com/twit/live/low" ;}

tv-stream-shows() { rtmpdump -r "rtmpe://192.99.38.122/bling0110hljdhaflhfahdfpadhfhurhgydhfbvkchugfayei/" -a "bling0110hljdhaflhfahdfpadhfhurhgydhfbvkchugfayei/" -f "LNX 11,2,202,442" -W "http://www.tgun.tv/embeds2/jwplayer.flash.swf" -p "http://www.tgun.tv/embeds2/index.html?men02" -y "$1" | mplayer - ;}
tv-stream-shows-two-and-a-half-men() { tv-stream-shows "men02" }
tv-stream-shows-the-x-files() { tv-stream-shows "xfiles02" }
tv-stream-shows-mash() { tv-stream-shows "mash02" }
tv-stream-shows-breaking-bad() { tv-stream-shows "bad02" }
