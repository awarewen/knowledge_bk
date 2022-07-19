# nginx部署环境准备

- gcc
- c++
- make

## nginx 基本管理

`nginx` ——启动nginx服务
`netstat -anptu | grep nginx` ——监听nginx是否启动成功
`killall -s QUIT nginx` ——关闭nginx服务
`killall -3 nginx` ——关闭nginx服务
`killall -1 nginx` ——重启nginx服务
`killall -s HUP nginx` ——重启nginx服务

### 使用脚本管理nginx

- `/etc/init.d/nginx` Nginx服务管理脚本

```bash
#!/bin/bash
#chkconfig: 35 90 30
#description:nginx server
PROG="/usr/local/nginx/sbin/nginx"
PIDF="/usr/local/nginx/logs/nginx.pid"
case "$1" in
start)
$PROG
;;
stop)
kill -s QUIT $(cat $PIDF)
;;
restart)
$0 stop
$0 start
;;
reload)
kill 0s HUP $(cat $PIDF)
;;
*)
echo "Usage:$0 (start|stop|restart|reload)"
exit 1
esac
exit 0
```

`chmod +x /etc/init.d/nginx` ——添加执行权限
`chkconfig --add nginx` ——添加nginx为系统服务
`chkconfig --level 35 nginx on` ——设置开机自动启动
`etc/init.d/nginx stop` ——脚本命令停止nginx服务
`etc/init.d/nginx start` ——脚本命令启动nginx服务
`etc/init.d/nginx restart` ——脚本命令重启nginx服务
