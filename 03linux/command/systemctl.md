# linux service管理 
## 常用
### 启用服务
```
systemctl start firewall.service
```

### 停止服务
```
systemctl stop firewall.service
```

### 开机启用
```
systemctl enable firewall.service
```
> * 可选
> --now: 立即应用命令

### 开机禁用
```
systemctl disable firewall.service
```
> * 可选
> --now: 立即应用命令

### 重启服务
```
systemctl restart firewall.service
```

### 显示一个服务的状态
```
systemctl status firewall.service
```

### 查询服务是否开机禁用
```
systemctl is-enable firewall.service
```
