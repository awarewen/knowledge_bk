# archlinux N 卡驱动
yay -S nvidia-utils nvidia-dims 
如果使用特殊的linux内核还需要安装对应的包
# 禁用开源驱动
```sh
/etc/modprobe.d/blacklist-nouveau.conf
______________________________________
blacklist nouveau
options nouveau modeset=0
```
# 手动加载N卡驱动
```sh
/usr/bin/nvidia-modprobe
```
