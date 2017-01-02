#!/bin/sh

if [ $1 != "RECEIVED" ]; then
        exit 0
fi

NADAWCA=$(awk '/^From:/ {print $2}' $2)
ODBIORCA="48600123456"
WIADOMOSC=$(sed '13!d' $2)

lte=$(grep LTE $2)
on=$(grep "zostala wlaczona" $2)
off=$(grep "zostala wylaczona" $2)


WAN_IF="wwan0"
MODEM_IF="/dev/ttyUSB0"

echo "New Message from: $NADAWCA , msg: $WIADOMOSC"

if [ ! -z "$lte" ] && [ ! -z "$off" ] ; then

        ifdown lte
#       ip link set dev $WAN_IF down

#		iptables -I INPUT -i $WAN_IF -j DROP
#		iptables -I FORWARD -o $WAN_IF -j DROP
#		iptables -I FORWARD -i $WAN_IF -j DROP
#		iptables -I OUTPUT -o $WAN_IF -j DROP

        echo "To: $ODBIORCA" > /tmp/sms
        echo "" >> /tmp/sms
        echo "Promocja Darmowy Internet LTE zostala wylaczona. Blokowanie internetu..." >> /tmp/sms

        mv /tmp/sms /var/spool/sms/outgoing/

		echo -e "AT^SYSCFGEX=\"030201\",3FFFFFFF,1,2,800C5,,\r" > $MODEM_IF
		echo -e "AT+CMGF=1;^CURC=0;^USSDMODE=0\r" > $MODEM_IF
		echo -e "AT+CUSD=1,\"*111*480*1#\"\r" > $MODEM_IF
#		echo -e "AT+CUSD=1,\"*111*480*1#\",15\r" > $MODEM_IF

        exit 0

elif [ ! -z "$lte" ] && [ ! -z "$on" ] ; then

        ifup lte
#       ip link set dev $WAN_IF up

#		iptables -D INPUT -i $WAN_IF -j DROP
#		iptables -D FORWARD -o $WAN_IF -j DROP
#		iptables -D FORWARD -i $WAN_IF -j DROP
#		iptables -D OUTPUT -o $WAN_IF -j DROP

        echo "To: $ODBIORCA" > /tmp/sms
        echo "" >> /tmp/sms
        echo "Promocja Darmowy Internet LTE zostala ponownie wlaczona. Przywracanie dostepu do internetu..." >> /tmp/sms

        mv /tmp/sms /var/spool/sms/outgoing/

        exit 0

else

	echo "To: $ODBIORCA" > /tmp/sms
	echo "" >> /tmp/sms
	echo "nr: $NADAWCA msg: $WIADOMOSC" >> /tmp/sms

	mv /tmp/sms /var/spool/sms/outgoing

fi

exit 0
