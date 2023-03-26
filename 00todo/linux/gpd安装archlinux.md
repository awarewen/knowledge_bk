# archlinux install
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
提前准备：

- 1个合适大小的U盘，32G
- 下载好windows linux的iso镜像文件

文档最终实现目标: 双系统 windows && ArchLinux 共存

## 启动盘
### dd/pv命令制作启动盘

`sudo dd if=/path/to/isofile of=/dev/sdx`
`sudo pv if=/path/to/isofile of=dev/sdx`

### ventoy制作多系统启动盘

安装ventoy后选择对应U盘，注意：这将会自动格式化U盘
然后将所有的iso文件拷贝到U盘中去即可。

### TIP

我使用 `dd` 烧录 `arch linux ISO` 镜像，遇到一个奇怪的问题，第一次烧录完成后live正常是可以跑的，但是我U盘放置了两天后就进不去了，提示找不到 `label`。
镜像系统也就无法启动，我后面又尝试重新使用 dd 但是结果一样，可能原因是：
  在liveCD是根据label名称挂载的，但是dd写的时候没有写分区label
尝试用wipefs --all /dev/sdb命令清除label，重新dd仍然一样，切换pv /path/to/iso > /dev/sdx 解决

[WIKI中描述了一个非常类似的问题](https://wiki.archlinux.org/title/USB_flash_installation_medium)
  
## 链接网络

安装镜像中提供了 `iwd` 软件包，使用 `iwctl` 进入交互模式

[ArchWiki#iwd](https://wiki.archlinux.org/title/Iwd_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

`device list /查看网卡设备名称一般为wlanx`
`station device_name scan /扫描`
`station device_name get-networks /列出可用网络`
`station device_name connect SSID /链接到SSID名称的wifi`

- 一行命令
  `iwctl --passphrase passphrase station device_name connect SSID`

## 更改时间

`timedatectl set-ntp true`

## 分区扩容

- EFI分区
  我电脑是UEFI启动方式，已经安装了windows系统，所以直接用windows的EFI分区。
  有一个问题是windows默认的EFI分区的大小只有100M，有点小，所以我想对EFI分区进行扩容
了解了一些分区扩容的方案:LVM(逻辑卷管理)、但是对我来说最合适的还是，将硬盘格式化直接重新分区

### 扩容和格式化分区

分区有两种简单的选择方案，此文档仅适用于第二种共存方案：

1. 如果要直接安装linux系统或多个linux系统
  可以一次分好区，一般情况下新的linux系统直接沿用同一个EFI分区即可

2. 安装linux和windows系统共存
  选择windows共存的话需要注意，在分完区后需要先安装windows系统，否则windows系统会覆盖linux启动引导

用cfdisk命令将这个磁盘中的旧分区全部删除重新分区，然后格式化分区文件系统

我采取的分区方案：
    - EFI -> 1G //mkfs.fat -F 32
    - linux根分区 -> 500G //mkfs.ext4
    - linuxSwap -> 18G //mkswap , swapon
    - windows主分区 -> 150G //mkfs.ntfs
    - windowsDATA -> 280G //mkfs.ntfs

[wiki.archlinux.org: EFI_system_partition](https://wiki.archlinux.org/title/EFI_system_partition)
[wiki.archlinux.org: File_systems](https://wiki.archlinux.org/title/File_systems)


## 交换分区

`mkswap /dev/xxx`
`swapon /dev/xxx`
`free #查看`

##基本配置


### 镜像源更换

```bash
refilector --country China --age 72 --sort rate --protocol https --save /etc/pacman.d/mirrorlist
```

### 安装基础系统软件

```base
pacstrap /mnt base base-devel linux linux-firmware vim git dhcpcd e2fsprogs os-prober
```

### 生成文件系统

```
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
```

## 进入系统

```
arch-chroot /mnt
```

### 设置时区同步硬件时钟

```
ln -sf /usr/share/zoneinfo/Asia/Shanghai /ect/localtime
hwclock --systohc
```

### 本地化

```
sed -i 's/^#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
sed -i 's/^#zh_CN.UTF-8/zh_CN.UTF-8/' /etc/locale.gen
locale-gen
```
/etc/hostname
/etc/hosts

### yay

添加源地址
```
echo "[archlinuxcn]\nServer = https://repo.huaweicloud.com/archlinuxcn/$arch" >> /etc/pacman.conf
```

`sudo pacman -S yay archlinuxcn-keyring`

### fcitx5 输入法支持

```
fcitx5
fcitx5-chinese-addons # 
fcitx5-configtool
fcitx5-gtk
fcitx5-input-support
fcitx5-material-color # theme
#*# 
fcitx5-pinyin-moegirl 
~fcitx5-pinyin-sougou~
fcitx5-pinyin-zhwiki
fcitx5-qt
```

### 更改默认shell

`chsh -s /usr/bin/zsh`

### 安装zsh shell主题 p10k

使用zinit安装p10k

## liveCD屏幕方向不对

liveCD中ttyN屏幕显示方向是错误的，导致我全程歪着头看屏幕，差点颈椎侧弯。
那么解决也比较简单。

首先在ttyN下 xrandr 命令旋转屏幕的命令并不起效果
(arch论坛`Digit`提供的解决方案)[https://bbs.archlinux.org/viewtopic.php?id=94059]—— `echo x > /sys/class/graphics/fbcon/rotate_all`

x 可以是 0,1,2,3 ,分别对应不同的旋转

在/etc/default/grub GRUB_COMDLINE_LINUX选项中添加 fbcon=rotate:x 持久化

[永久保存TTYN屏幕显示方向](https://www.codenong.com/cs106691096/)

### 桌面模式下的屏幕显示方向

安装iio-sensor-proxy-git kded-rotation-git自动旋转屏幕方向

### sddm 登陆界面的显示方向不对

`echo xrandr -o left > /usr/share/sddm/scripts/Xsetup`

## 改变ttyN 下字体大小

在 `/usr/share/kbd/consolefonts/` 下放了terminus-font 字体包中的许多字体
使用setfont font_name可以立即使字体设置生效
我选择的是ter-u32b

- 持久化
在安装完基础系统后创建vconsole.conf文件写入 FONT=ter-u32b

## 分区label重写

VFAT文件系统： dosfslabel
ntfs文件系统： ntfslabel

## 一些其他的故障问题

[此部分内容来源于：CSDN —— walsons](https://blog.csdn.net/weixin_44720401/article/details/113182382)

### 声卡驱动

如果系统无法检测到声卡，请查看驱动程序

```bash
alsa-firmware
sof-firmware
alsa-ucm-conf
```

### 启动盘找不到移动硬盘

使用移动硬盘安装archlinux系统，可能出现找不到移动硬盘：
安装 grub EFI ：`grub-install --target=x86_64-efi --efi-directory=/boot --removable --recheck`

- removable: 移动介质参数
- recheck: 检查设备

### 闪屏

在内核中添加 `nomodeset` 关闭 KMS ， 就是进入 grub 选择页面时按 `e` 键
永久化： 向 `/etc/default/grub` 中添加 `GRUB_CMDLINE_LINUX_DEFAULT=loglevel=3 quiet nomodeset`

重新生成grub.cfg 文件： `grub-mkconfig -o /boot/grub/grub.cfg`

这可能会导致一些桌面的特效无法使用
如果是笔记本，闪屏的原因也有可能是面板的自我刷新（英特尔的iGPUs省电功能），解决方案： 添加 `i915.enable_psr=0` 到内核命令行中关闭此功能
