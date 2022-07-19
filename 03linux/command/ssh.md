# ssh连接服务端
ssh 连接服务器超时断线时间延长
/etc/ssh/sshd_config
```
ClientAliveInterval 60 #超时时间
ClientAliveCountMax 3 #尝试次数
```
