# gpd Pocket 3
Time: 2022/11/18
- 机器型号：Pocket 3,i7-1195G7 以下简称为 P3 
- 仅安装 ArchLinux 系统(非双系统)
- 文件系统：XFS+LVM
- 桌面：bspwm
---
**参考:**

[Arch linux 202208版本安装实录_Kong_Sir的博客-CSDN博客](https://blog.csdn.net/zo2k123/article/details/126325231)

[2022.5 archlinux详细安装过程 - 知乎](https://zhuanlan.zhihu.com/p/513859236)

[Arch Linux 安装教程（基础安装篇） - 哔哩哔哩](https://www.bilibili.com/read/cv16392057)

[安装Arch Linux【2022.09.10】 - 知乎](https://zhuanlan.zhihu.com/p/112541071)

[Installation guide - ArchWiki](https://wiki.archlinux.org/title/Installation_guide)

[在 LVM 上安装 Arch Linux - ArchWiki](https://wiki.archlinux.org/title/Install_Arch_Linux_on_LVM)

[ArchWiki:GPD_pocket_3](https://wiki.archlinux.org/title/GPD_Pocket_3)

---
> 关于P3固件更新  [GPD Pocket 3 - ArchWiki](https://wiki.archlinux.org/title/GPD_Pocket_3#Firmware)

 P3 不支持 fwupd 更新固件，目前仅支持通过 Windows 程序提供固件更新 \
 由于硬件驱动问题 手写笔(Digitizer) 有部分功能支持不完善，指纹传感器(Fingerprint Sensor)不支持
##  安装前准备
- arch linux镜像---[推荐在arch官网下载](https://archlinux.org/download/)
- ventoy 启动盘制作工具
- U盘

## archlinux 安装
### 1. 制作 Live CD
使用 [ventoy](https://github.com/ventoy/Ventoy.git) 制作启动盘 

### 2. 进入 Live CD 

1. 临时改变显示方向方案\
    P3 屏幕默认是逆时针旋转90度显示，因为 P3 显示屏是专为纵向设备设计的\
    `# echo 1 > /sys/class/graphics/fbcon/rotate_all`

2. 解决 TTY 字体过小---[linux console](https://wiki.archlinux.org/title/Linux_console_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)) \
    `# setfont ter-u32b`

### 3. 检查 boot 支持

- `# ls /sys/firmware/efi/efivars` \
  如果该目录不存在，系统可能是 BIOS(或CSM) 模式启动，目录存在则是以 UEFI 模式启动

### 4. 连接网络
  以下所使用的命令都是安装镜像预配置和启用的
- 有线连接使用 DHCP 获取 ip 和 DNS\
  `# dhcpcd`

- 无线网\
  使用 ip-link 查看网卡状态 \
  `# ip link`
  - 如果无线网卡被禁用，使用 rfkill 解除限制 [ArchWiki_rfkill](https://wiki.archlinux.org/title/Network_configuration/Wireless#Rfkill_caveat)

  使用 iwctl 扫描并连接 wifi\
 `# station wlan0 connect SSID`
>- 查看网卡名称：`# device list`，如果网卡没启用：`# device device_name set-property Powered on`
>
>- 扫描 wifi: `# station device_name scan`，显示扫描结果：`# station device_name get-networks`
>
>- 连接wifi: `# station device_name connect SSID-wifi_name`
>
>- 连接隐藏wifi，扫描获取目标AP设备的MAC: `# station device_name get-hidden-access-points`，连接：`# station device_name connect AP-MAC`

- 拨号连接(PPP/PPPOE) (实验暂时没成功)
> 使用 `# pppoe-setup` 填写你的配置，启动 `# pppoe-start`，关闭 `# pppoe-stop`
#### 5. 更新系统时钟
`# timedatectl set-ntp true`
#### 6. XFS+LVM 分区
1T SSD 硬盘分区方案(此方案不具备任何参考建议，请根据需要确定分区大小): 

- EFI分区 -- 1G 奢侈且好用
- linux swap -- 18G
- / 根分区 -- 500G
- home 分区 -- 400G
- var 分区 -- 剩下的部分空间

文件系统类型规划

使用分区工具 cfdisk
- EFI分区---分区类型：`linux efi`
- 交换分区--分区类型：`linux swap`
- 根分区 --- 分区类型: `linux LVM`
- var分区 -- 分区类型：`linux LVM`
- home分区--分区类型：`linux LVM`

格式化分区
根分区 `# mkfs.ext4 /dev/root_partition`
交换分区 `# mkswap /dev/swap_partition && swapon /dev/swap_partition && free` 使用 free 命令检查交换分区启用是否成功

挂载分区
根分区 ：`# mount /dev/root_partition`
EFI分区：`# mount --mkdir /dev/efi_system_partition /mnt/boot`
#### 7. 镜像安装
切换国内镜像源
`# reflector -c China -a 10 --sort rate --save /etc/pacman.d/mirrorlist`
安装基本包
`# pacstrap -k /mnt base linux linux-firmware`

# 重新开始
## 仅安装 archlinux
### live cd
### 分区
#### XFS
查看可以用作物理卷的设备
- `# lvmdiskscan`
创建标头
`# pvcreate /dev/nvme0n1px`
创建卷组
`# `
Cannot archive volume group metadata for centos to read-only filesyste
- mount -o umount rw /


备忘软件
usbmuxd -usb设备驱动

 1. 可以通过添加内核参数解决\
    - 打开 '/etc/default/grub' ，在 `GRUB_CMDLINE_LINUX=` 添加 \
      `fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up`
    - 重新生成 GRUB 配置文件: `# grub-mkconfig -o /boot/grub/grub.cfg`

> 持久化: 创建打开/etc/vconsole.conf 添加FONT=ter-u32b，[vconsole 介绍](https://man.archlinux.org/man/vconsole.conf.5)
