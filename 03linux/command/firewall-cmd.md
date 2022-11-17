# firewall-cmd 防火墙的控制命令
## 常用
### 查看防火墙状态
```
firewall-cmd --state
```

### 启用,打开防火墙
```
systemctl start firewalld
```

### 查看打开端口
```
firewall-cmd --list-all
firewall-cmd --list-port
firewall-cmd --zone=public --list-ports
```

### 热重启
```
firewall-cmd --reload
```

### 添加端口
```
firewall-cmd --zone=public --add-port=80/tcp --permanent
# 打开端口后需要重启防火墙
```
> - permanent
> 将此设置永久化，写入配置中

### 删除端口
```
firewall-cmd --zone=public --remove-port=80/tcp --permanent
# 关闭端口后需要重启防火墙
```
> - permanent
> 将此设置永久化，写入配置中

## 非常用
### 查看指定端口所属区域
```
firewall-cmd --get-zone-of-interface=eth0
```

### 查看区域信息
```
firewall-cmd --get-active-zones
```

### 拒绝所有包
```
firewall-cmd --panic-on
```

### 取消拒绝所有包
```
firewall-cmd --panic-off
```

### 查看是否拒绝所有包
```
firewall-cmd --query-panic
```
