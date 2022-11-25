# gpd Pocket 3
Time: 2022/11/22


```md
- 机器型号：  Pocket 3,i7-1195G7 以下简称为 P3
- 仅安装      ArchLinux 系统(非双系统)
- 启动方式：  EFI+bios
- 文件系统：  lvm+btrfs+zfs
- 桌面：      bspwm
```
[TOC]
---
## **参考:**
- [Arch-Install-Note/arch安装,lvm+btrfs+zfs.md at main · a15355447898a/Arch-Install-Note · GitHub](https://github.com/a15355447898a/Arch-Install-Note/blob/main/arch%E5%AE%89%E8%A3%85%2Clvm%2Bbtrfs%2Bzfs.md)

- [Arch linux 202208版本安装实录_Kong_Sir的博客-CSDN博客](https://blog.csdn.net/zo2k123/article/details/126325231)

- [2022.5 archlinux详细安装过程 - 知乎](https://zhuanlan.zhihu.com/p/513859236)

- [Arch Linux 安装教程（基础安装篇） - 哔哩哔哩](https://www.bilibili.com/read/cv16392057)

- [安装Arch Linux【2022.09.10】 - 知乎](https://zhuanlan.zhihu.com/p/112541071)

- [Installation guide - ArchWiki](https://wiki.archlinux.org/title/Installation_guide)

- [在 LVM 上安装 Arch Linux - ArchWiki](https://wiki.archlinux.org/title/Install_Arch_Linux_on_LVM)

- [ArchWiki:GPD_pocket_3](https://wiki.archlinux.org/title/GPD_Pocket_3)

- [mount-oremountrw命令 - 百度文库](https://wenku.baidu.com/view/f82936054b2fb4daa58da0116c175f0e7cd119c8.html?_wkts_=1669002848566&bdQuery=mount+-o+umount+rw+%2F)

- [host: Network configuration - ArchWiki](https://wiki.archlinux.org/title/Network_configuration#Set_the_hostname)

---
> 关于P3固件更新  [GPD Pocket 3 - ArchWiki](https://wiki.archlinux.org/title/GPD_Pocket_3#Firmware)

 P3 不支持 fwupd 更新固件，目前仅支持通过 Windows 程序提供固件更新 \
 由于硬件驱动问题 手写笔(Digitizer) 有部分功能支持不完善，指纹传感器(Fingerprint Sensor)不支持
##  安装前准备
- arch linux镜像---[推荐在arch官网下载](https://archlinux.org/download/)
- [ventoy](https://github.com/ventoy/Ventoy.git) 启动盘制作工具
- U盘

## archlinux 安装
### 1. 制作 Live CD
使用 ventoy 制作启动盘, 注意由于ventoy会将整个U盘格式化，请准备一个空的U盘，或提前做好数据备份\
启动盘制作完成后将系统镜像文件拷贝到U盘即可

### 2. 进入 Live CD 
更改电脑启动方式为U盘启动

1. 临时改变显示方向，并解决 TTY 字体过小---[linux console](https://wiki.archlinux.org/title/Linux_console_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)) （安装完基础系统后会有持久化的方法）
    - P3 屏幕默认是逆时针旋转90度显示，因为 P3 显示屏是专为纵向设备设计的\
    ```sh
    echo 1 > /sys/class/graphics/fbcon/rotate_all

    setfont ter-u32b
    ```

### 3. 连接网络
  > 以下所使用的命令都是安装镜像预配置和启用的
---
- 有线连接使用 DHCP 获取 ip 和 DNS\
  `# dhcpcd`

- 无线网\
  使用 ip-link 查看网卡状态 \
  `# ip link`
  - 如果无线网卡被禁用，使用 rfkill 解除限制 [ArchWiki_rfkill](https://wiki.archlinux.org/title/Network_configuration/Wireless#Rfkill_caveat)

  使用 iwctl 扫描并连接 wifi\
 `# station wlan0 connect SSID`
 ```md

 # 查看网卡名称(Driver Name)
 $ device list

 # 扫描 wifi
 $ station DeviceName scan

 # 显示扫描结果
 $ station DeviceName get-networks

 # 连接wifi 
 $ station DeviceName connect SSID-Wifi-Name

 连接隐藏 wifi
 # 扫描获取目标AP设备的MAC 
 $ station DeviceName get-hidden-access-points
 ## 使用MAC连接 
 $ station DeviceName connect AP-MAC`
```

- 拨号连接(PPP/PPPOE) (待考证)
> 使用 `# pppoe-setup` 填写你的配置，启动 `# pppoe-start`，关闭 `# pppoe-stop`

#### 4. 更新系统时钟
`# timedatectl set-ntp true`

#### 6. 分区
考虑：
安装完系统
快照 : home 排除文件的列表 home下单独的一些目录做一些快照
| 根卷 /
  | 子卷/homepool
      | /
  | 子卷/snapshots

1T SSD 硬盘分区方案 (使用 cfdisk): 
 |driver_name | part_name   | filesystem | size       |
 |------------|-------------|------------|------------|
 |nvme0n1p1   | system boot | BIOS boot  |  2M        |
 |nvme0n1p2   | EFI         | EFI System |  1G        |
 |nvme0n1p3   | linux swap  | linux swap |  18G       |
 |nvme0n1p4   | Arch        | Linux LVM  |  剩下的空间|

1. 创建物理卷标记(PV)
```
# pvcreate  /dev/nvme0n1p4
```
- 检查物理卷 \
`# pvdisplay`, `# pvscan`

2. 创建卷组(VG)
```
# vgcreate Arch /dev/nvme0n1p3
```
- 检查：
 `# vgdisplay`，`# vgscan`


5. 创建逻辑卷(LV)
```
# lvcreate -l 100%FREE roots -n root 
# lvcreate -l 100%FREE homes -n home
# lvcreate -l 100%FREE vars  -n var
```
检查：`# lvdisplay`

6. 格式化分区
```
# mkfs.fat -F 32 /dev/nvme0n1p1
# mkswap /dev/nvme0n1p2
# mkfs.xfs /dev/mapper/roots-root
# mkfs.xfs /dev/mapper/homes-home
# mkfs.xfs /dev/mapper/vars-var
```

7. 挂载分区
```
# mount --mkdir /dev/nvme0n1p1 /mnt/boot
# swapon /dev/nvme0n1p2
# mount /dev/mapper/roots-root /mnt
# mount --mkdir /dev/mapper/homes-home /mnt/home
# mount --mkdir /dev/mapper/vars-var /mnt/var
```
检查分区挂载：`# lsblk`

> ##### TIP
>> Cannot archive volume group metadata for centos to read-only filesyste\
`# mount -o umount rw /` 将原先是只读的文件系统以可读写的模式重新挂载


#### 7. 镜像安装
切换国内镜像源\
`# reflector -c China -a 10 --sort rate --save /etc/pacman.d/mirrorlist`\
安装基本包\
首先保证基本的文件系统，网络，文本编辑\
`# pacstrap -k /mnt base linux linux-firmware networkmanager dhcpcd vim linux-headers bash-completion git openssh base-devel lvm2 xfsprogs intel-ucode os-prober grub`\
'os-prober 检测多系统引导'

#### 8. 生成分区表\
`# genfstab -U /mnt >> /mnt/etc/fstab`\
检查分区表：`# cat /mnt/etc/fstab`\
请仔细查对分区表所对应的UUID是否正确，查看是否有漏缺

#### 9. 切换根目录\
`# arch-chroot /mnt`

#### 配置 LVM 支持和grub\
1. 在 'HOOKS=".... 添加 lvm2"'\
`# vim /etc/mkinitcpio.conf`

2. grub 预设
`# vim /etc/default/grub`\
添加 lvm 模块加载
```
GRUB_PRELOAD_MODULES="lvm"
```

3. install grub
`# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch --recheck`

4. 生成 grub 配置
`# grub-mkconfig -o /boot/grub/grub.cfg`


#### 10. 校正时区
```bash
 ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
 hwclock --systohc
```

#### 11. 本地化\
将 'en_US.UTF-8 UTF-8' 'zh_CN.UTF-8 UTF-8' 取消注释
```bash
 vim /etc/local.gen
 # locale-gen 生成locale
 echo "LANG=en_US.UTF-8" >> /etc/locale.conf
 echo "your_hostname" >> /etc/hostname
```
设置 hostname 解析，虽然在 systemd 中提供了 NSS 模块无需配置 /etc/hosts 就可以使用本地主机名称解析服务，但是一些程序仍然会依赖于 /etc/hosts 文件 (请见:[Network configuration - ArchWiki](https://wiki.archlinux.org/title/Network_configuration#localhost_is_resolved_over_the_network))
```
127.0.0.1       localhost
::1             localhost
127.0.0.1       your_hostname.localdomain   your_hostname
```

#### 12. Root用户和普通用户\
设置 root 用户密码
```bash
passwd root
```

- 添加普通用户并添加到 wheel 用户组
> 创建
`# useradd -m -g users -G wheel,storage,power the_user_name`
> 设置密码
`# passwd the_user_name`
> 为 wheel 用户组更改用户权限
`# EDIOR=vim visudo`\
找到 'Uncomment to allow members of group wheel to execute any command' 将下一行配置取消注释

#### 13. 重启

备忘软件
usbmuxd -usb设备驱动

 1. 可以通过添加内核参数解决\
    - 打开 '/etc/default/grub' ，在 `GRUB_CMDLINE_LINUX=` 添加 \
      `fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up`
    - 重新生成 GRUB 配置文件: `# grub-mkconfig -o /boot/grub/grub.cfg`

> 持久化: 创建打开/etc/vconsole.conf 添加FONT=ter-u32b，[vconsole 介绍](https://man.archlinux.org/man/vconsole.conf.5)
>
> partprobe 同步硬盘更改
wipefs 擦除分区filesystem标记

## 记录LVM移除卷
创建 pv - vg - lv
移除 lv - vg - pv
如果移除时提示 read-only ：mount -o remount,rw -a (mount -o remount rw /) 以可读写的方式重新挂在所有设备


# 重新记录
live cd 启动后
iwctl 连接网络
timedatectl set-ntp 1 
reflector
sudo pacman -Syy
清除磁盘标记 1: wipefs -a /dev/sda(磁盘名称不是分区)
建立分区
boot - 2M BIOS boot
efi  - 1G EFI System
swap - 18G Linux swap
root - 500G Linux LVM
home - 400G Linux LVM -- home+snapshots

创建lvm
pv
pvc /dev/root_driver_name /dev/home_driver_name
vg
vgc Arch /dev/root_driver_name
vgc homes /dev/home_driver_name
lv
lvc -l 100%FREE Arch -n root
lvc -L 50G homes -n .snapshots
lvc -l +100%FREE homes -n home


格式化
boot 分区不格式化
efi - mkfa.fat -F32 /dev/efi_driver_name
swpa - mkswap /dev/swap_driver_name -L swap
root - mkfs.xfs /dev/mapper/Arch-root
home - mkfs.xfs /dev/mapper/homes-home
.snapshots - mkfs.xfs /dev/mapper/homes-.snapshots

挂载
mount --mkdir /dev/nvme0n1p2 /mnt/boot/efi
mount --mkdir /dev/mapper/Arch-root /mnt
mount --mkdir /dev/mapper/homes-home /mnt/home
mount --mkdir /dev/mapper/homes-.snapshots /mnt/.snapshots

安装基本系统
pacman-key --init
pacstrap /mnt base base-devel linux-lts linux-lts-headers linux-firmware neovim vim networkmanager lvm2 grub efibootmgr dhcpcd bash-completion openssh xfsprogs intel-ucode os-prober

## 重新记录
文件系统采用btrfs 使用自带snapshots功能
磁盘划分
2M boot
1G EFI
18G swap
400G Root - btrfs
400G home - btrfs
130G snapshots - btrfs

