#!/bin/sh

if [ $1 != "RECEIVED" ]; then
        exit 0
fi

# play 753924
NADAWCA=$(awk '/^From:/ {print $2}' $2)
ODBIORCA="48600123456"
WIADOMOSC=$(sed '13!d' $2)

lte=$(grep LTE $2)
on=$(grep wlaczona $2)
off=$(grep wylaczona $2)

WAN_IF="wwan0"
MODEM_IF="/dev/ttyUSB0"

if [ ! -z "$NADAWCA" ] && [ ! -z "$lte" ] && [ ! -z "$off" ] ; then
	iptables -I INPUT -i $WAN_IF -j DROP
	iptables -I FORWARD -o $WAN_IF -j DROP
	iptables -I FORWARD -i $WAN_IF -j DROP
	iptables -I OUTPUT -o $WAN_IF -j DROP

	echo -e "AT+CMGF=1;^CURC=0;^USSDMODE=0\r" > $MODEM_IF
	sleep 1
	echo -e "AT+CUSD=1,\"*111*480*1#\",15\r" > $MODEM_IF

	echo "To: $ODBIORCA" > /tmp/sms
	echo "" >> /tmp/sms
	echo "Promocja Darmowy Internet LTE zostala wylaczona. Zakladanie blokady na iptables." >> /tmp/sms

	mv /tmp/sms /var/spool/sms/outgoing/

#	ifdown wan
#	ip link set dev $WAN_IF down

	exit 0

elif [ ! -z "$NADAWCA" ] && [ ! -z "$lte" ] && [ ! -z "$on" ] ; then
	iptables -D INPUT -i $WAN_IF -j DROP
	iptables -D FORWARD -o $WAN_IF -j DROP
	iptables -D FORWARD -i $WAN_IF -j DROP
	iptables -D OUTPUT -o $WAN_IF -j DROP

	echo "To: $ODBIORCA" > /tmp/sms
	echo "" >> /tmp/sms
	echo "Promocja Darmowy Internet LTE zostala ponownie wlaczona. Sciaganie blokady iptables." >> /tmp/sms

	mv /tmp/sms /var/spool/sms/outgoing/

#	ifup wan
#	ip link set dev $WAN_IF up

	exit 0

else
	echo "To: $ODBIORCA" > /tmp/sms
	echo "" >> /tmp/sms
	echo "nr: $NADAWCA\nmsg: $WIADOMOSC" >> /tmp/sms

	mv /tmp/sms /var/spool/sms/outgoing

fi

exit 0
