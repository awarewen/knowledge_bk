# 偷偷摸摸整活
v2ray 就不多做介绍了，如果不知道想了解可以自行百度。

自备机场这里简单介绍我目前使用的搭建方案。
多平台通用，速度稳定，使用了差不多1个多月没被封IP。

# 环境
linux客户端：v2ray核心+Qv2ray
linux发行版本：archlinux
服务端linux发行版本：centos7
服务端搭建脚本：bash <(curl -s -L https://git.io/v2ray.sh)

# 服务端配置方案
刚开始传输协议我用的是 `WebSocket + TLS`，有点坑，我就想不通为啥我做了伪装域名，证书也没问题可是用了一个星期就给我433端口封了，换端口之后用1天又给我封了，不知道是不是那段时间查得紧。

后面改用了 `TCP+HTTP` 速度虽然稍慢但也没啥感觉，用了也有一段时间没被封，所以我几百软妹币的域名有点亏了，不过后面准备拿去搭个博客网站也行。
服务端直接拿脚本配置v2ray省事也不容易出问题。

端口不要用常用的，20000左右的都可以，没啥要求就随便填一个只要到时候客户端对的上就好。
![[v2ray一键脚本.png]]

## 端口配置
服务端我的是 `centos7` ，我的服务端提供商内置了`BBR`加速。

- 防火墙命令：
![[firewall-cmd#常用]]
	- 检查防火墙状态：systemctl status firewalld.service
	- 打开需要的端口(端口号可以自己改)：firewall-cmd --zone=public --add-port=20008/tcp --permanent
	- 查看所有打开的端口：firewall-cmd --list-all
	- 移除一个端口：firewall-cmd --zone=public --remove-port=20008/tcp --permanent
	- 打开或者移除都记得要重启一下防火墙配置：firewall-cmd --reload
>  建议打开的端口：22，433，80，53，8080

## 生成客户端配置
```bash
# 两种都可以
$ v2ray url
$ v2ray qr #方便手机客户端扫码添加
```

# 配置客户端
![[Qv2ray客户端设置.png]]
- 监听本地地址：127.0.0.1
- 设置系统代理选上
- socks/HTTP端口自行配置

- 任意门可以和 [[cgproxy]]配合实现全局代理
	- 注意如果服务端没有开启`UDP`和`IPv6`代理就不要填写选中
	- **模式选择tproxy的话还需要为 `tproxy` 设置 `root` 权限：`sudo setcap " cap_net_admin,cap_net_bind_service=ep " /usr/lib/v2ray/v2ray `**
	- `出站mark` 为 `0`
	 > ![[qv2ray任意门png.png]]
	 
	 ^v2ray01
	 
# 添加 `vemss` 链接
![[qv2rayVEMSS.png]]
> 导入 -> 粘贴VEMSS链接 -> 导入

# 到此就可以愉快的冲浪了。
手机版请自行去找可用的v2ray 客户端 ：`Nv2ray` 这里不提供下载链接 