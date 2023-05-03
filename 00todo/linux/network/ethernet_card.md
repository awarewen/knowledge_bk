# 查看当前往口的最大速率
cat /sys/class/net/enp175s0/speed

# 查看当前网卡支持的最大速率
lspci -vvv | grep Ethernet
