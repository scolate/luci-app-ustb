#!/bin/sh

V6=$(uci get ustb.@login[0].enableV6)
Gateway=$(ip -6 route | sed -n "/default from/p" | awk '{print $5}')
Eth=$(ip -6 route | sed -n "/default from/p" | awk '{print $7}')
sed -i "/ip -6 r add default via .* dev .*/d" /etc/firewall.user
sed -i "/ip6tables -t nat -A POSTROUTING -o .* -j MASQUERADE/d" /etc/firewall.user
sed -i "/# The following two rules is Nat6 for USTB/d" /etc/firewall.user
if [ "$V6" != "1" ]; then
	/etc/init.d/firewall restart >/dev/null
	return
fi
if [ "$Gateway" != "" ] && [ "$Eth" != "" ]; then
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] Got IPV6 Net Interface ${Eth} and Gateway ${Gateway}" >>/usr/share/USTB/link.log
	echo '# The following two rules is Nat6 for USTB' >>/etc/firewall.user
	echo "ip -6 r add default via ${Gateway} dev ${Eth}" >>/etc/firewall.user
	echo "ip6tables -t nat -A POSTROUTING -o ${Eth} -j MASQUERADE" >>/etc/firewall.user
	/etc/init.d/firewall restart >/dev/null
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] Firewall restart finished" >>/usr/share/USTB/link.log
else
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] Can't find IPV6 Gateway or Net Interface. Please check your IPV6" >>/usr/share/USTB/link.log
fi