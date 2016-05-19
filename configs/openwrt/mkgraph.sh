#!/bin/sh

HOST="the-mountain"
#DATADIR="/mnt/ftp/sda3/router/stats"
DATADIR="/tmp/router/stats"
#IMAGEDIR="/mnt/ftp/sda3/router/www/stats/$HOST/"
IMAGEDIR="/tmp/router/www/stats/$HOST/"
PLUGINS="cpu-0 interface iwinfo-wlan0 iwinfo-wlan1 load memory ping conntrack dns"
PERIOD="1hour 12hours 24hours 48hours"
INTERFACES="eth0 br-lan wlan0 wlan1"
WIFI_INTERFACES="wlan0 wlan1"


for PLUGIN in $PLUGINS
do
	mkdir -p $IMAGEDIR/$PLUGIN
done


###############################
#         cpu section         #
###############################
cpu0_cpu_ilde(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/cpu-0/cpu-idle-$TIME.png -t "$HOST/cpu-0/cpu-idle $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/cpu-0/cpu-idle.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/cpu-0/cpu-idle.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/cpu-0/cpu-idle.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf%% %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf%% %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf%% %s\n" \
		>/dev/null 2>&1
	done
}

cpu0_cpu_interrupt(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/cpu-0/cpu-interrupt-$TIME.png -t "$HOST/cpu-0/cpu-interrupt $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/cpu-0/cpu-interrupt.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/cpu-0/cpu-interrupt.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/cpu-0/cpu-interrupt.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}

cpu0_cpu_nice(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/cpu-0/cpu-nice-$TIME.png -t "$HOST/cpu-0/cpu-nice $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/cpu-0/cpu-nice.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/cpu-0/cpu-nice.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/cpu-0/cpu-nice.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}

cpu0_cpu_softirq(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/cpu-0/cpu-softirq-$TIME.png -t "$HOST/cpu-0/cpu-softirq $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/cpu-0/cpu-softirq.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/cpu-0/cpu-softirq.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/cpu-0/cpu-softirq.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}

cpu0_cpu_steal(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/cpu-0/cpu-steal-$TIME.png -t "$HOST/cpu-0/cpu-steal $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/cpu-0/cpu-steal.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/cpu-0/cpu-steal.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/cpu-0/cpu-steal.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}

cpu0_cpu_wait(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/cpu-0/cpu-wait-$TIME.png -t "$HOST/cpu-0/cpu-wait $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/cpu-0/cpu-wait.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/cpu-0/cpu-wait.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/cpu-0/cpu-wait.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}

cpu0_cpu_system(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/cpu-0/cpu-system-$TIME.png -t "$HOST/cpu-0/cpu-system $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/cpu-0/cpu-system.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/cpu-0/cpu-system.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/cpu-0/cpu-system.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}

cpu0_cpu_user(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/cpu-0/cpu-user-$TIME.png -t "$HOST/cpu-0/cpu-user $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/cpu-0/cpu-user.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/cpu-0/cpu-user.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/cpu-0/cpu-user.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}
##############################

##############################
#     interface section      #
##############################
interfaces_if_errors(){
	for INTERFACE in $INTERFACES
	do
		for TIME in $PERIOD
		do
			rrdtool graph $IMAGEDIR/interface/if_errors-$INTERFACE-$TIME.png -t "$HOST/interface/if_errors-$INTERFACE $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
			DEF:rx_min=$DATADIR/$HOST/interface-$INTERFACE/if_errors.rrd:rx:MIN \
			DEF:rx_avg=$DATADIR/$HOST/interface-$INTERFACE/if_errors.rrd:rx:AVERAGE \
			DEF:rx_max=$DATADIR/$HOST/interface-$INTERFACE/if_errors.rrd:rx:MAX \
			DEF:tx_min=$DATADIR/$HOST/interface-$INTERFACE/if_errors.rrd:tx:MIN \
			DEF:tx_avg=$DATADIR/$HOST/interface-$INTERFACE/if_errors.rrd:tx:AVERAGE \
			DEF:tx_max=$DATADIR/$HOST/interface-$INTERFACE/if_errors.rrd:tx:MAX \
			AREA:rx_max#ffe8e8 \
			AREA:tx_max#e8e8ff \
			LINE2:rx_max#ff7777:rx \
			GPRINT:rx_avg:MIN:"Minimum\:%8.2lf %s" \
			GPRINT:rx_avg:AVERAGE:"Average\:%8.2lf %s" \
			GPRINT:rx_max:MAX:"Maximum\:%8.2lf %s\n" \
			LINE2:tx_max#7777ff:tx \
			GPRINT:tx_avg:MIN:"Minimum\:%8.2lf %s" \
			GPRINT:tx_avg:AVERAGE:"Average\:%8.2lf %s" \
			GPRINT:tx_max:MAX:"Maximum\:%8.2lf %s\n" \
			>/dev/null 2>&1
		done
	done
}

interfaces_if_octets(){
	for INTERFACE in $INTERFACES
	do
		for TIME in $PERIOD
		do
			rrdtool graph $IMAGEDIR/interface/if_octets-$INTERFACE-$TIME.png -t "$HOST/interface/if_octets-$INTERFACE $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
			DEF:rx_min=$DATADIR/$HOST/interface-$INTERFACE/if_octets.rrd:rx:MIN \
			DEF:rx_avg=$DATADIR/$HOST/interface-$INTERFACE/if_octets.rrd:rx:AVERAGE \
			DEF:rx_max=$DATADIR/$HOST/interface-$INTERFACE/if_octets.rrd:rx:MAX \
			DEF:tx_min=$DATADIR/$HOST/interface-$INTERFACE/if_octets.rrd:tx:MIN \
			DEF:tx_avg=$DATADIR/$HOST/interface-$INTERFACE/if_octets.rrd:tx:AVERAGE \
			DEF:tx_max=$DATADIR/$HOST/interface-$INTERFACE/if_octets.rrd:tx:MAX \
			AREA:rx_max#ffe8e8 \
			AREA:tx_max#e8e8ff \
			LINE2:rx_max#ff7777:rx \
			GPRINT:rx_avg:MIN:"Minimum\:%8.2lf %s" \
			GPRINT:rx_avg:AVERAGE:"Average\:%8.2lf %s" \
			GPRINT:rx_max:MAX:"Maximum\:%8.2lf %s\n" \
			LINE2:tx_max#7777ff:tx \
			GPRINT:tx_avg:MIN:"Minimum\:%8.2lf %s" \
			GPRINT:tx_avg:AVERAGE:"Average\:%8.2lf %s" \
			GPRINT:tx_max:MAX:"Maximum\:%8.2lf %s\n" \
			>/dev/null 2>&1
		done
	done
}

interfaces_if_packets(){
	for INTERFACE in $INTERFACES
	do
		for TIME in $PERIOD
		do
			rrdtool graph $IMAGEDIR/interface/if_packets-$INTERFACE-$TIME.png -t "$HOST/interface/if_packets-$INTERFACE $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
			DEF:rx_min=$DATADIR/$HOST/interface-$INTERFACE/if_packets.rrd:rx:MIN \
			DEF:rx_avg=$DATADIR/$HOST/interface-$INTERFACE/if_packets.rrd:rx:AVERAGE \
			DEF:rx_max=$DATADIR/$HOST/interface-$INTERFACE/if_packets.rrd:rx:MAX \
			DEF:tx_min=$DATADIR/$HOST/interface-$INTERFACE/if_packets.rrd:tx:MIN \
			DEF:tx_avg=$DATADIR/$HOST/interface-$INTERFACE/if_packets.rrd:tx:AVERAGE \
			DEF:tx_max=$DATADIR/$HOST/interface-$INTERFACE/if_packets.rrd:tx:MAX \
			AREA:rx_max#ffe8e8 \
			AREA:tx_max#e8e8ff \
			LINE2:rx_max#ff7777:rx \
			GPRINT:rx_avg:MIN:"Minimum\:%8.2lf %s" \
			GPRINT:rx_avg:AVERAGE:"Average\:%8.2lf %s" \
			GPRINT:rx_max:MAX:"Maximum\:%8.2lf %s\n" \
			LINE2:tx_max#7777ff:tx \
			GPRINT:tx_avg:MIN:"Minimum\:%8.2lf %s" \
			GPRINT:tx_avg:AVERAGE:"Average\:%8.2lf %s" \
			GPRINT:tx_max:MAX:"Maximum\:%8.2lf %s\n" \
			>/dev/null 2>&1
		done
	done
}
##############################

##############################
#       iwinfo section       #
##############################
iwinfo_bitrate(){

	for INTERFACE in $WIFI_INTERFACES
	do
		for TIME in $PERIOD
		do
			rrdtool graph $IMAGEDIR/iwinfo-$INTERFACE/bitrate-$TIME.png -t "$HOST/iwinfo-$INTERFACE/bitrate $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
			DEF:value_min=$DATADIR/$HOST/iwinfo-$INTERFACE/bitrate.rrd:value:MIN \
			DEF:value_avg=$DATADIR/$HOST/iwinfo-$INTERFACE/bitrate.rrd:value:AVERAGE \
			DEF:value_max=$DATADIR/$HOST/iwinfo-$INTERFACE/bitrate.rrd:value:MAX \
			AREA:value_max#ffe8e8 \
			LINE2:value_max#ff7777:value \
			GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
			GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
			GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
			>/dev/null 2>&1
		done
	done
}

iwinfo_signal_noise(){
	for INTERFACE in $WIFI_INTERFACES
	do
		for TIME in $PERIOD
		do
			rrdtool graph $IMAGEDIR/iwinfo-$INTERFACE/signal_noise-$TIME.png -t "$HOST/iwinfo-$INTERFACE/signal_noise $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
			DEF:value_min=$DATADIR/$HOST/iwinfo-$INTERFACE/signal_noise.rrd:value:MIN \
			DEF:value_avg=$DATADIR/$HOST/iwinfo-$INTERFACE/signal_noise.rrd:value:AVERAGE \
			DEF:value_max=$DATADIR/$HOST/iwinfo-$INTERFACE/signal_noise.rrd:value:MAX \
			AREA:value_max#ffe8e8 \
			LINE2:value_max#ff7777:value \
			GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
			GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
			GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
			>/dev/null 2>&1
		done
	done
}

iwinfo_signal_power(){
	for INTERFACE in $WIFI_INTERFACES
	do
		for TIME in $PERIOD
		do
			rrdtool graph $IMAGEDIR/iwinfo-$INTERFACE/signal_power-$TIME.png -t "$HOST/iwinfo-$INTERFACE/signal_power $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
			DEF:value_min=$DATADIR/$HOST/iwinfo-$INTERFACE/signal_power.rrd:value:MIN \
			DEF:value_avg=$DATADIR/$HOST/iwinfo-$INTERFACE/signal_power.rrd:value:AVERAGE \
			DEF:value_max=$DATADIR/$HOST/iwinfo-$INTERFACE/signal_power.rrd:value:MAX \
			AREA:value_max#ffe8e8 \
			LINE2:value_max#ff7777:value \
			GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
			GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
			GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
			>/dev/null 2>&1
		done
	done
}

iwinfo_signal_quality(){
	for INTERFACE in $WIFI_INTERFACES
	do
		for TIME in $PERIOD
		do
			rrdtool graph $IMAGEDIR/iwinfo-$INTERFACE/signal_quality-$TIME.png -t "$HOST/iwinfo-$INTERFACE/signal_quality $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
			DEF:value_min=$DATADIR/$HOST/iwinfo-$INTERFACE/signal_quality.rrd:value:MIN \
			DEF:value_avg=$DATADIR/$HOST/iwinfo-$INTERFACE/signal_quality.rrd:value:AVERAGE \
			DEF:value_max=$DATADIR/$HOST/iwinfo-$INTERFACE/signal_quality.rrd:value:MAX \
			AREA:value_max#ffe8e8 \
			LINE2:value_max#ff7777:value \
			GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
			GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
			GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
			>/dev/null 2>&1
		done
	done
}

iwinfo_stations(){
	for INTERFACE in $WIFI_INTERFACES
	do
		for TIME in $PERIOD
		do
			rrdtool graph $IMAGEDIR/iwinfo-$INTERFACE/stations-$TIME.png -t "$HOST/iwinfo-$INTERFACE/stations $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
			DEF:value_min=$DATADIR/$HOST/iwinfo-$INTERFACE/stations.rrd:value:MIN \
			DEF:value_avg=$DATADIR/$HOST/iwinfo-$INTERFACE/stations.rrd:value:AVERAGE \
			DEF:value_max=$DATADIR/$HOST/iwinfo-$INTERFACE/stations.rrd:value:MAX \
			AREA:value_max#ffe8e8 \
			LINE2:value_max#ff7777:value \
			GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
			GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
			GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
			>/dev/null 2>&1
		done
	done
}
##############################

##############################
#        load section        #
##############################
load_load(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/load/load-$TIME.png --title "$HOST/load/load $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:longterm_min=$DATADIR/$HOST/load/load.rrd:longterm:MIN \
		DEF:longterm_avg=$DATADIR/$HOST/load/load.rrd:longterm:AVERAGE \
		DEF:longterm_max=$DATADIR/$HOST/load/load.rrd:longterm:MAX \
		DEF:midterm_min=$DATADIR/$HOST/load/load.rrd:midterm:MIN \
		DEF:midterm_avg=$DATADIR/$HOST/load/load.rrd:midterm:AVERAGE \
		DEF:midterm_max=$DATADIR/$HOST/load/load.rrd:midterm:MAX \
		DEF:shortterm_min=$DATADIR/$HOST/load/load.rrd:shortterm:MIN \
		DEF:shortterm_avg=$DATADIR/$HOST/load/load.rrd:shortterm:AVERAGE \
		DEF:shortterm_max=$DATADIR/$HOST/load/load.rrd:shortterm:MAX \
		AREA:longterm_max#ffe8e8 \
		AREA:midterm_max#e8e8ff \
		AREA:shortterm_max#e2ffe2 \
		LINE2:shortterm_max#55ff55:1min \
		GPRINT:shortterm_avg:MIN:" Minimum\:%8.2lf %s" \
		GPRINT:shortterm_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:shortterm_max:MAX:"Maximum\:%8.2lf %s\n" \
		LINE2:midterm_max#7777ff:5min \
		GPRINT:midterm_avg:MIN:" Minimum\:%8.2lf %s" \
		GPRINT:midterm_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:midterm_max:MAX:"Maximum\:%8.2lf %s\n" \
		LINE2:longterm_max#ff7777:15min \
		GPRINT:longterm_avg:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:longterm_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:longterm_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}
##############################

##############################
#       MEMORY section       #
##############################

memory_buffered(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/memory/memory-buffered-$TIME.png -t "$HOST/memory/memory-buffered $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/memory/memory-buffered.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/memory/memory-buffered.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/memory/memory-buffered.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}

memory_cached(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/memory/memory-cached-$TIME.png -t "$HOST/memory/memory-cached $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/memory/memory-cached.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/memory/memory-cached.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/memory/memory-cached.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}

memory_free(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/memory/memory-free-$TIME.png -t "$HOST/memory/memory-free $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/memory/memory-free.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/memory/memory-free.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/memory/memory-free.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}

memory_used(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/memory/memory-used-$TIME.png -t "$HOST/memory/memory-used $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/memory/memory-used.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/memory/memory-used.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/memory/memory-used.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}
##############################

##############################
#        PING section        #
##############################
ping_ping(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/ping/ping-$TIME.png -t "$HOST/ping/ping $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:google_min=$DATADIR/$HOST/ping/ping-8.8.8.8.rrd:value:MIN \
		DEF:google_avg=$DATADIR/$HOST/ping/ping-8.8.8.8.rrd:value:AVERAGE \
		DEF:google_max=$DATADIR/$HOST/ping/ping-8.8.8.8.rrd:value:MAX \
		DEF:wp_min=$DATADIR/$HOST/ping/ping-212.77.100.101.rrd:value:MIN \
		DEF:wp_avg=$DATADIR/$HOST/ping/ping-212.77.100.101.rrd:value:AVERAGE \
		DEF:wp_max=$DATADIR/$HOST/ping/ping-212.77.100.101.rrd:value:MAX \
		DEF:opendns_min=$DATADIR/$HOST/ping/ping-208.67.220.220.rrd:value:MIN \
		DEF:opendns_avg=$DATADIR/$HOST/ping/ping-208.67.220.220.rrd:value:AVERAGE \
		DEF:opendns_max=$DATADIR/$HOST/ping/ping-208.67.220.220.rrd:value:MAX \
		AREA:google_max#ffe8e8 \
		AREA:wp_max#e8e8ff \
		AREA:opendns_max#e2ffe2 \
		LINE2:google_max#ff7777:google.com \
		GPRINT:google_min:MIN:" Minimum\:%8.2lf %s" \
		GPRINT:google_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:google_max:MAX:"Maximum\:%8.2lf %s\n" \
		LINE2:wp_max#7777ff:wp.pl \
		GPRINT:wp_min:MIN:"      Minimum\:%8.2lf %s" \
		GPRINT:wp_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:wp_max:MAX:"Maximum\:%8.2lf %s\n" \
		LINE2:opendns_max#55ff55:opendns.com \
		GPRINT:opendns_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:opendns_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:opendns_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}

ping_droprate(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/ping/ping_droprate-$TIME.png -t "$HOST/ping/ping_droprate $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:google_min=$DATADIR/$HOST/ping/ping_droprate-8.8.8.8.rrd:value:MIN \
		DEF:google_avg=$DATADIR/$HOST/ping/ping_droprate-8.8.8.8.rrd:value:AVERAGE \
		DEF:google_max=$DATADIR/$HOST/ping/ping_droprate-8.8.8.8.rrd:value:MAX \
		DEF:wp_min=$DATADIR/$HOST/ping/ping_droprate-212.77.100.101.rrd:value:MIN \
		DEF:wp_avg=$DATADIR/$HOST/ping/ping_droprate-212.77.100.101.rrd:value:AVERAGE \
		DEF:wp_max=$DATADIR/$HOST/ping/ping_droprate-212.77.100.101.rrd:value:MAX \
		DEF:opendns_min=$DATADIR/$HOST/ping/ping_droprate-208.67.220.220.rrd:value:MIN \
		DEF:opendns_avg=$DATADIR/$HOST/ping/ping_droprate-208.67.220.220.rrd:value:AVERAGE \
		DEF:opendns_max=$DATADIR/$HOST/ping/ping_droprate-208.67.220.220.rrd:value:MAX \
		AREA:google_max#ffe8e8 \
		AREA:wp_max#e8e8ff \
		LINE2:google_max#ff7777:google.com \
		GPRINT:google_min:MIN:" Minimum\:%8.2lf %s" \
		GPRINT:google_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:google_max:MAX:"Maximum\:%8.2lf %s\n" \
		LINE2:wp_max#7777ff:wp.pl \
		GPRINT:wp_min:MIN:"      Minimum\:%8.2lf %s" \
		GPRINT:wp_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:wp_max:MAX:"Maximum\:%8.2lf %s\n" \
		LINE2:opendns_max#55ff55:opendns.com \
		GPRINT:opendns_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:opendns_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:opendns_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}

ping_stddev(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/ping/ping_stddev-$TIME.png -t "$HOST/ping/ping_stddev $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:google_min=$DATADIR/$HOST/ping/ping_stddev-8.8.8.8.rrd:value:MIN \
		DEF:google_avg=$DATADIR/$HOST/ping/ping_stddev-8.8.8.8.rrd:value:AVERAGE \
		DEF:google_max=$DATADIR/$HOST/ping/ping_stddev-8.8.8.8.rrd:value:MAX \
		DEF:wp_min=$DATADIR/$HOST/ping/ping_stddev-212.77.100.101.rrd:value:MIN \
		DEF:wp_avg=$DATADIR/$HOST/ping/ping_stddev-212.77.100.101.rrd:value:AVERAGE \
		DEF:wp_max=$DATADIR/$HOST/ping/ping_stddev-212.77.100.101.rrd:value:MAX \
		DEF:opendns_min=$DATADIR/$HOST/ping/ping_stddev-208.67.220.220.rrd:value:MIN \
		DEF:opendns_avg=$DATADIR/$HOST/ping/ping_stddev-208.67.220.220.rrd:value:AVERAGE \
		DEF:opendns_max=$DATADIR/$HOST/ping/ping_stddev-208.67.220.220.rrd:value:MAX \
		AREA:google_max#ffe8e8 \
		AREA:wp_max#e8e8ff \
		LINE2:google_max#ff7777:google.com \
		GPRINT:google_min:MIN:" Minimum\:%8.2lf %s" \
		GPRINT:google_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:google_max:MAX:"Maximum\:%8.2lf %s\n" \
		LINE2:wp_max#7777ff:wp.pl \
		GPRINT:wp_min:MIN:"      Minimum\:%8.2lf %s" \
		GPRINT:wp_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:wp_max:MAX:"Maximum\:%8.2lf %s\n" \
		LINE2:opendns_max#55ff55:opendns.com \
		GPRINT:opendns_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:opendns_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:opendns_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}
##############################

##############################
#      conntrack section     #
##############################
conntrack_conntrack(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/conntrack/conntrack-$TIME.png -t "$HOST/conntrack/conntrack $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:value_min=$DATADIR/$HOST/conntrack/conntrack.rrd:value:MIN \
		DEF:value_avg=$DATADIR/$HOST/conntrack/conntrack.rrd:value:AVERAGE \
		DEF:value_max=$DATADIR/$HOST/conntrack/conntrack.rrd:value:MAX \
		AREA:value_max#ffe8e8 \
		LINE2:value_max#ff7777:value \
		GPRINT:value_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:value_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:value_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}
##############################

##############################
#         dns section        #
##############################
dns_octets(){
	for TIME in $PERIOD
	do
		rrdtool graph $IMAGEDIR/dns/dns_octets-$TIME.png -t "$HOST/dns/dns_octets $TIME" --imgformat PNG --width 600 --height 100 --start now-$TIME --end now --interlaced \
		DEF:queries_min=$DATADIR/$HOST/dns/dns_octets.rrd:queries:MIN \
		DEF:queries_avg=$DATADIR/$HOST/dns/dns_octets.rrd:queries:AVERAGE \
		DEF:queries_max=$DATADIR/$HOST/dns/dns_octets.rrd:queries:MAX \
		DEF:responses_min=$DATADIR/$HOST/dns/dns_octets.rrd:responses:MIN \
		DEF:responses_avg=$DATADIR/$HOST/dns/dns_octets.rrd:responses:AVERAGE \
		DEF:responses_max=$DATADIR/$HOST/dns/dns_octets.rrd:responses:MAX \
		AREA:queries_max#ffe8e8 \
		AREA:responses_max#e8e8ff \
		LINE2:queries_max#ff7777:queries \
		GPRINT:queries_min:MIN:"  Minimum\:%8.2lf %s" \
		GPRINT:queries_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:queries_max:MAX:"Maximum\:%8.2lf %s\n" \
		LINE2:responses_max#7777ff:responses \
		GPRINT:responses_min:MIN:"Minimum\:%8.2lf %s" \
		GPRINT:responses_avg:AVERAGE:"Average\:%8.2lf %s" \
		GPRINT:responses_max:MAX:"Maximum\:%8.2lf %s\n" \
		>/dev/null 2>&1
	done
}
##############################

###
cpu0_cpu_ilde
#cpu0_cpu_interrupt
#cpu0_cpu_nice
#cpu0_cpu_softirq
#cpu0_cpu_steal
#cpu0_cpu_wait
#cpu0_cpu_system
#cpu0_cpu_user


###
#interfaces_if_errors
interfaces_if_octets
#interfaces_if_packets

###
iwinfo_bitrate
#iwinfo_signal_noise
iwinfo_signal_power
iwinfo_signal_quality
iwinfo_stations

###
load_load

###
#memory_buffered
#memory_cached
#memory_free
memory_used

###
ping_ping
#ping_droprate
#ping_stddev

###
conntrack_conntrack

###
dns_octets
