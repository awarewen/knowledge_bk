# setp 1

install ppp program

# 检查内核是否开启pppoe支持
$ zgrep CONFIG_PPPOE /proc/config.gz
CONFIG_PPPOE=m

# Configuration
/etc/ppp/peers/ make_config
```
plugin pppoe.so
# rp_pppoe_ac 'ac name'
# rp_pppoe_service 'service name'

# network interface
etho
# login name
name " loginname "
usepeerdns
persist

# Uncomment this if you want to enable dial on demand
#demand
#idle 180
defalultroute
hide-password
noauth
```

# 装一个setpppoe (yay)
