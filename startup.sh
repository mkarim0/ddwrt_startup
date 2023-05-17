sleep 15
get_traffic(){
    RX="$(/sbin/ifconfig eth0 | grep -o '[[:digit:]]*' | sed -n 22p)"
    TX="$(/sbin/ifconfig eth0 | grep -o '[[:digit:]]*' | sed -n 25p)"
    XB="$(awk "BEGIN {print $RX + $TX}")"
    XM=$(awk "BEGIN {print int($XB / (1000*1000))}")
}
get_traffic

interface_down(){ /sbin/ifconfig eth0 down 2>/dev/null && exit; }

while true
do
 get_traffic
 if [ $XM -gt 4710 ]
 then
   interface_down
 fi
 

 sleep 10
done
