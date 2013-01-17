echo "Running self tests..." > /tmp/test.log
echo "Checking if we are connected to the internet..."
ping -c1 -q 8.8.8.8 >> /tmp/test.log && echo "Ok."
echo "Checking DNS..."
ping -c1 -q google.com >> /tmp/test.log && echo "Ok."
echo "Checking if drugtestbots.info is online..."
ping -c1 -q drugtestbots.info >> /tmp/test.log && echo "Ok."
echo "Checking if tinc is running..."
ps | grep -v grep | grep -q tincd && echo "Ok."
echo "Checking if tinc is connected..."
grep -q "`uci get system.@system[0].hostname` -> drugtestbots" /var/log/tinc.ffulm.dot && echo "Ok."
echo "Checking if batman is running..."
lsmod | grep -q batman_adv && echo "Ok."
echo "Checking if tinc is connected to batman..."
batctl if | grep -q "tinc: active" && echo "Ok."
echo "Checking if batman sees other nodes..."
batctl o | grep -q "No batman nodes in range ..." || echo -e "Ok. The following nodes are visible:\n`batctl o | tail -n +3 | awk '{print \" \" $1}'`"
echo "Checking if batman sees other nodes via tinc..."
batctl o | grep -q tinc && echo -e "Ok. The following nodes are visible:\n`batctl o | grep tinc | grep -v 'B.A.T.M.A.N.' | awk '{print \" \" $1}'`"
echo "Checking if the IPv6 is correctly configured..."
ifconfig br-lan | grep -q "2a01:348:12f:`uci get system.@system[0].hostname`::1" && echo "Ok."
echo "Checking if batman is part of the bridge..."
brctl show | grep -q bat0 && echo "Ok."
echo "Checking if we can ping6 drugtestbots via batman..."
ping6 -c1 2a01:348:12f::1 >> /tmp/test.log && echo "Ok."
