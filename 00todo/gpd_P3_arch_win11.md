#       GPD Pocket 3
CreateTime: 2022/11/22

```sh
        - 机器型号：  Pocket 3,i7-1195G7 以下简称为 P3
        - 仅安装      ArchLinux 系统(非双系统)
        - 启动方式：  EFI+bios
        - 文件系统：  lvm+btrfs+zfs
        - 桌面：      bspwm
```
[TOC]
---
## **参考:**
-  [Arch-Install-Note/arch安装,lvm+btrfs+zfs -----------GitHub](https://github.com/a15355447898a/Arch-Install-Note/blob/main/arch%E5%AE%89%E8%A3%85%2Clvm%2Bbtrfs%2Bzfs.md)

- [Arch linux 202209版本安装实录--------------------------SDN博客](https://blog.csdn.net/zo2k123/article/details/126325231)

- [2022.5 archlinux详细安装过程--------------------------- 知乎](https://zhuanlan.zhihu.com/p/513859236)

- [Arch Linux 安装教程（基础安装篇）------------------- 哔哩哔哩](https://www.bilibili.com/read/cv16392057)

- [安装Arch Linux【2022.09.10】--------------------------知乎](https://zhuanlan.zhihu.com/p/112541071)

- [Installation guide--------------------------------------------ArchWiki](https://wiki.archlinux.org/title/Installation_guide)

- [在 LVM 上安装 Arch Linux---------------------------------ArchWiki](https://wiki.archlinux.org/title/Install_Arch_Linux_on_LVM)

- [ArchWiki:GPD_pocket_3-----------------------------------ArchWiki](https://wiki.archlinux.org/title/GPD_Pocket_3)

- [mount-oremountrw命令----------------------------------百度文库](https://wenku.baidu.com/view/f82936054b2fb4daa58da0116c175f0e7cd119c8.html?_wkts_=1669002848566&bdQuery=mount+-o+umount+rw+%2F)

- [host: Network configuration - --------------------------ArchWiki](https://wiki.archlinux.org/title/Network_configuration#Set_the_hostname)

- [ defencore/gpd-pocket-3-linux--------------------------GitHub](https://github.com/defencore/gpd-pocket-3-linux)

- [bspwm 入门 ---------------------------------------------------哔哩哔哩](https://www.bilibili.com/read/cv7417123)

- [从零开始的Bspwm安装与配置教程---------------------知乎](https://zhuanlan.zhihu.com/p/568211941)

##      **TIP**
- [FS#68945：user_readenv --------------------------------# .pam_environment 已弃用](https://bugs.archlinux.org/task/68945)
- [Network configuration  ------------------------------------# about hosts --- ArchWiki](https://wiki.archlinux.org/title/Network_configuration#localhost_is_resolved_over_the_network)

---
> 关于P3固件更新  [GPD Pocket 3 - ArchWiki](https://wiki.archlinux.org/title/GPD_Pocket_3#Firmware)

 P3 不支持 fwupd 更新固件，目前仅支持通过 Windows 程序提供固件更新 \
 由于硬件驱动问题 手写笔(Digitizer) 有部分功能支持不完善，指纹传感器(Fingerprint Sensor)不支持

##      安装前准备
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
    - P3 屏幕默认是逆时针旋转90度显示，因为 P3 显示屏是专为纵向设备设计的
```sh
    echo 1 > /sys/class/graphics/fbcon/rotate_all

    setfont ter-u32b
```

### 3. 连接网络
>   以下所使用的命令都是安装镜像预配置和启用的
---

```sh
#   有线连接
#   使用 DHCP 获取 ip 和 DNS
    dhcpcd

#   无线网
#   使用 ip-link 查看网卡状态 
    ip link
```
- 如果无线网卡被禁用，使用 rfkill 解除限制 [ArchWiki_rfkill](https://wiki.archlinux.org/title/Network_configuration/Wireless#Rfkill_caveat)


 ```sh
#   使用 iwctl 扫描并连接 wifi
#   查看网卡名称(Driver Name)
    device list

#   扫描 wifi
    station 'DeviceName' scan

#   显示扫描结果
    station 'DeviceName' get-networks

#   连接wifi 
    station 'DeviceName' connect 'SSID-Wifi-Name'

#   连接隐藏 wifi
##  扫描获取目标AP设备的MAC 
    station 'DeviceName' get-hidden-access-points
##  使用MAC连接 
    station 'DeviceName' connect 'AP-MAC'
```

- 拨号连接(PPP/PPPOE) (待考证)
> 使用 `pppoe-setup` 填写你的配置，启动 `pppoe-start`，关闭 `pppoe-stop`

### 4. 更新系统时钟
```sh
#    如果不进行此步可能造成后续下载基本系统失败
     timedatectl set-ntp true
```

### 5. 分区

- 1T SSD 硬盘分区方案 (使用 cfdisk): 

     |Driver_name | Part_name   | Filesystem | Size       | 备注|
     |------------|-------------|------------|------------|--
     |nvme0n1p1   | system boot | BIOS boot  |  2M        |启动分区
     |nvme0n1p2   | EFI         | EFI System |  1G        |启动分区
     |nvme0n1p3   | linux swap  | linux swap |  18G       |交换分区
     |nvme0n1p4   | Arch        | Linux LVM  |  剩下的空间|root/home/snapshots


```sh
#   创建物理卷标记(PV)
    pvcreate  /dev/nvme0n1p4

#   检查物理卷
    pvdisplay 
    pvs

#   创建卷组(VG)
    vgcreate Arch /dev/nvme0n1p3

#   检查：
    vgdisplay
    vgs

#   创建逻辑卷(LV)

    lvcreate -L 400G Arch -n root
    lvcreate -L 400G Arch -n homepool
    lvcreate -l +100%FREE Arch -n .snapshots

    # 检查：
    lvdisplay

    lvs

    4. 格式化分区

    mkfs.vfat /dev/nvme0n1p2
    mkswap /dev/nvme0n1p3
    swapon /dev/nvme0n1p3
    mkfs.btrfs /dev/mapper/Arch-root
    mkfs.btrfs /dev/mapperArch-homepool

    5. 创建btrfs子卷

    mount /dev/mapper/Arch-root /mnt
    cd /mnt
    btrfs subvolume create @
    cd /
    umount /mnt

    mount /dev/mapper/Arch-.snapshots /mnt
    cd /mnt
    btrfs subvolume create @snapshots
    cd /
    umount /mnt

    mount /dev/mapper/Arch-homepool /mnt
    cd /mnt
    btrfs subvolume create @home
    cd /
    umount /mnt

    8. 挂载
    mount /dev/mapper/Arch-root /mnt -o subvol=@

    mkdir /mnt/boot
    mount /dev/nvme0n1p2 /mnt/boot

    mkdir /mnt/home
    mount /dev/mapper/Arch-homepool /mnt/home -o subvol=@home

    mkdir /mnt/.snapshots
    mount /dev/mapper/Arch-.snapshots /mnt/.snapshots -o subvol=@snapshots
```
> ##### TIP
` mount -o remount,rw -a`将原先是只读的文件系统以可读写的模式重新挂载


#### 7. 镜像安装
```sh
# 更新镜像
reflector -c China -a 10 --sort rate --save /etc/pacman.d/mirrorlist

# 安装archlinux-keyring 刷新密钥
pacman -Syy archlinux-keyring
# 安装基本包
pacstrap -k /mnt base linux linux-firmware networkmanager network-manager-applet\
                  dhcpcd vim neovim linux-headers bash-completion zsh\
                  git openssh base-devel lvm2 btrfs-progs\
                  intel-ucode  efibootmgr grub
# ~btrfs-progs~
# ~xfsprogs~
# @os-prober 
# --检测多系统引导
```

#### 8. 生成分区表
```sh
genfstb -U /mnt >> /mnt/etc/fstab

# 检查分区表：
cat /mnt/etc/fstab
```
- 请仔细查对分区表所对应的UUID是否正确，查看是否有漏缺

#### 9. 切换根目录
```sh
arch-chroot /mnt
```
#### 10. 配置 LVM 支持和grub
1. mkinitcpio 钩子
```sh
vim /etc/mkinitcpio.conf
__________________________
'HOOKS=".... lvm2'
# @ HOOKS="... lvm2 filesystems"请在filesystems 前面添加 lvm2模块加载

## for btrfs check
MODULES=(btrfs)
BINARIES=(btrfs)
```
2. Grub 参数
- [GRUB (简体中文) - ArchWiki](https://wiki.archlinux.org/title/GRUB_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#BIOS_%E7%B3%BB%E7%BB%9F)
```sh
vim /etc/default/grub
_____________________
GRUB_PRELOAD_MODULES="... btrfs"
GRUB_DISABLE_OS_PROBER=false
GRUB_CMDLINE_LINUX_DEFAULT="... root=/dev/mapper/Arch-root nowatchdog"
# @nowatchdog
# --减少关机时需要等待的时间
```

3. Install Grub

```sh
# BIOS_boot 
## 注意留空的 '2M' 未格式化分区，用来存放 'BIOS_boot' 方式启动所需要文件
grub-install --target=i386-pc /dev/nvme0n1
# @'/dev/nvme0n1' 
# --注意此处为设备名称而非分区名称 'nvme0n1p1'

# UEFI_efi
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch --recheck
# @'--bootloader-id' 
# --指定一个显示在 GRUB 菜单的名称

# 生成 Grub 配置
grub-mkconfig -o /boot/grub/grub.cfg
```


#### 10. 校正时区

```sh
# 设置本地时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 同步硬件时钟
hwclock --systohc
 
```

#### 11. 本地化
```sh
# 将 'en_US.UTF-8 UTF-8' 'zh_CN.UTF-8 UTF-8' 取消注释
vim /etc/locale.gen
locale-gen

# 字符终端不要用 'zh_CN.UTF-8' 会中文乱码
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# 主机名
echo "your_hostname" >> /etc/hostname

# 设置 hostname 解析
# systemd 中提供了 NSS 模块无需配置 hosts 就可以使用本地主机名称解析服务
# 但是一些程序仍然会依赖于 /etc/hosts 文件 
# --(请见:[Network configuration - ArchWiki](https://wiki.archlinux.org/title/Network_configuration#localhost_is_resolved_over_the_network))
127.0.0.1       localhost
::1             localhost
127.0.0.1       'your_hostname'.localdomain   'your_hostname'
```

#### 12. Root用户和普通用户
```sh
# 设置 root 用户密码
passwd root

# 创建用户并添加到 wheel 用户组
useradd -m -g users -G wheel,storage,power 'the_user_name'

# 设置密码
passwd 'the_user_name'

# 为 wheel 用户组更改用户权限
EDIOR=vim visudo
# 找到 'Uncomment to allow members of group wheel to execute any command' 将下一行配置取消注释
```

#### 14. 安装桌面前的准备
```sh
# 提供基本的用户文件管理服务 [xdg-用户目录](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/)
sudo pacman -S xdg-user-dirs

# 安装sddm
```sh
sudo pacman -S sddm xorg
# @ 安装的时候可以选择noto-font字体已获得完整Unicode覆盖范围的Google字体系列 可以选择安装emoji cjk extra三个对应的可选依赖项
```

```
#### 15. systemed ：一些必要的服务配置
- disable dhcpcd
- enable NetworkManager
- enable sshd
- enable sddm

#### 16. SHELL
[Command-line shell - ArchWiki](https://wiki.archlinux.org/title/Command-line_shell)
检查当前用户默认SHELL:Zsh SHELL
```sh
echo $SHELL
chsh -l # 检查可用的SHELL
chsh -s /bin/zsh your_user_name`
```

#### 17. 配置pacman aur

1. 添加国内源打开,并32位支持
[2022.5 archlinux详细安装过程 - 知乎](https://zhuanlan.zhihu.com/p/513859236)
```sh
# nvim /etc/pacman.conf
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch

[Clansty]
SigLevel = Never
Server = https://repo.lwqwq.com/archlinux/$arch
Server = https://pacman.ltd/archlinux/$arch
Server = https://repo.clansty.com/archlinux/$arch

# 添加keyring
sudo pacman -S archlinuxcn-keyring
```
2. 安装 AUR HELPER
```sh
# 安装AUR helper
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
# 一些比较好用的可选依赖可以装一下
sudo pacman -S bat asp
```

#### 18. 驱动
- 显示
intel: `$ sudo pacman -S xf86-video-intel vulkan-intel`

- 蓝牙
`$ sudo pacman -S bluedevil`

- 声音
```sh
$ nvim /etc/modprobe.d/alsa.conf
-> options snd-intel-dspcfg dsp_driver=1
sudo pacman -S alsa-utils pulseaudio pulseaudio-bluetooth cups

# 2022 12/7
# @pulseaudio 被替换
# -- pipewire pipewire-pulse pipewire-zeroconf lib32-pipewire pipewire-alsa
# -- & pipewire 管理器选择：wireplumber
# @cups
```

#### 19. 解决 p3 显示，触屏方向问题，字体显示并持久化
- [GitHub - defencore/gpd-pocket-3-linux: GPD Pocket 3 Linux](https://github.com/defencore/gpd-pocket-3-linux)
1. 在TTY界面下的显示方向
- 临时解决方案
> `echo 1 > /sys/class/graphics/fbcon/rotate_all`
- 持久化：添加内核参数fbcon
```sh
# 打开/etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="... fbcon=rotate:1"
GRUB_CMDLINE_LINUX="... fbcon=rotate:1"
GRUB_GFXMODE=1200x1920x32
# 重新生成grub启动配置
sudo grub-mkconfig -0 /boot/grub/grub.cfg

# Tip
# -- 这并没能将Grub菜单旋转，等待修复
```
2. 在SDDM界面
```sh
# /usr/share/sddm/scripts/Xsetup
#! /bin/sh
xrandr -o right
```
3. 桌面
```sh
# 自动旋转屏幕方向
sudo iio-sensor-proxy-git kded-rotation-git
```

4. 触屏方向不对
```sh
# /etc/X11/xorg.conf.d/99-touchsreen.conf
Section   "InputClass"
  Identifier    "calibration"
  MatchProduct  "GXTP7380"
  Option        "TransformationMatrix" "0 1 0 -1 0 1 0 0 1"
EndSection

# 0°   Option "TransformationMatrix" "0 1 0 -1 0 1 0 0 1"
# 90°  Option "TransformationMatrix" "-1 0 1 0 -1 1 0 0 1"
# 180° Option "TransformationMatrix" "0 -1 1 1 0 0 0 0 1"
# 270° Option "TransformationMatrix" "1 0 0 0 1 0 0 0 1"

5. 自动旋转
```

5. 字体显示持久化 [vconsole 介绍](https://man.archlinux.org/man/vconsole.conf.5)
- 请安装 terminus-font
- 创建打开 `/etc/vconsole.conf` 添加 `FONT=ter-u32b` \
在 `/usr/share/kbd/consolefonts/` 下放了 `terminus-font` 字体包中的许多字体
使用 `setfont 'font_name'` 可以立即使字体设置生效


#### 19. 开始桌面环境配置
[从零开始的Bspwm安装与配置教程 - 知乎](https://zhuanlan.zhihu.com/p/568211941)
```sh
# 窗口管理器 bspwm 和快捷键守护进程 sxhkd
sudo pacman -S bspwm sxhkd

# 将 bspwm 的实例配置文件拷贝到 '.config' 目录下
mkdir ~/.config # .config 目录将作为大部分程序或软件的配置存放目录
cd ~/.config
cp /usr/share/doc/bspwm/examples/bspwmrc bspwm/
cp /usr/share/doc/bspwm/examples/sxhkdrc sxhkd/

# Firefox浏览器,Rofi应用启动器,Kitty终端
sudo pacman -S firefox rofi kitty

# 更改 sxhkdrc 配置
# kitty terminal 
super + Return
  kitty
# rofi program launcher
super + space
  rofi -show drun

# 重启
sudo reboot
```


#### 20. 输入法和字体
```sh
# 英文字体
pacman -S ttf-dejavu ttf-droid ttf-hack ttf-font-awesome otf-font-awesome ttf-lato ttf-liberation ttf-linux-libertine ttf-opensans ttf-roboto ttf-ubuntu-font-family

# 中文字体
pacman -S ttf-hannom noto-fonts noto-fonts-extra noto-fonts-emoji noto-fonts-cjk adobe-source-code-pro-fonts \
          adobe-source-sans-fonts adobe-source-serif-fonts adobe-source-han-sans-cn-fonts \
          adobe-source-han-sans-hk-fonts adobe-source-han-sans-tw-fonts adobe-source-han-serif-cn-fonts wqy-zenhei wqy-microhei
```

- fcitx5 框架、主题、词库
    - [Fcitx5 - ArchWiki](https://wiki.archlinux.org/title/Fcitx5#Configuration)
    - [Environment variables - ArchWiki](https://wiki.archlinux.org/title/Environment_variables#Defining_variables)
```sh
sudo pacman -S fcitx5-im fcitx5-chinese-addons fcitx5-material-color fcitx5-pinyin-moegirl fcitx5-pinyin-zhwiki
# @fcitx5-im：基础输入框架
# @fcitx5-chinese-addons 中文输入引擎
# @fcitx5-material-color 主题
# @fcitx5-pinyin-moegirl @fcitx5-pinyin-zhwiki 词库

# 添加运行环境参数
touch ~/.xprofile # X11
# @Tip:
# --不要使用'.pam_environment'
# --[FS#68945：[at][gdm][pambase] user_readenv 已弃用](https://bugs.archlinux.org/task/68945)
# --可以使用 '.xprofile','.zprofile','.bash_profile' 进行环境参数配置
#_______________________
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=\@im=fcitx
export INPUT_METHOD=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus # for kitty terminal

# fcitx5 自启
echo "fcitx5 &" >> ~/.config/bspwm/bspwmrc
```

#### 21. 修改字体渲染设置
```sh
vim /etc/profile.d/freetype2.sh
_______________________________
# 取消注释最后一句
export FREETYPE_PROPERTIES="truetype:interpreter-version=40"
```

####  dotfile 
- [awarewen/dots-2.0] (https://github.com/awarewen/dots-2.0)
```sh
yay -Sy acpi alsa-utils-git blueman brave-bin bspwm colorpicker dunst eww-git flameshot hsetroot imagemagick jq kitty
mantablockscreen network-manager-applet pa-applet-git  playerctl
polkit-gnome polybar pulseaudio python3 rofi scrot sox spicetify-cli spotify sxhkd thunar 
wmctrl wpgtk-git xclip xdotool xprintidle  --needed

# @ picom-animations-git xwinfo-git 这两个需要去git项目页面下载，AUR的包找不到了
# @ colorpicker ttf-abel-regular mantablockscreen spicetify-cli 如果实在无法下载，建议开启魔法上网

# 这个dot配置的依赖

# 一个用python和Qt编写的弹出通知工具
pop_report
# 依赖：pyqt5 argparse inotify
# 使用pip安装这些依赖


# 电源
acpi

# 声音
alsa-utils

# 蓝牙
blueman

brave

# 窗口管理器
bspwm

# 颜色拾取
colorpicker

# 通知
dunst

# bar
eww
polybar

flameshot
hsetroot
imagemagick
jq
kitty
mantablockscreen
network-manager-appler
pa-applet
picom-animations-git
playerctl
polkit-gnome
pulseaudio
python3
rofi
scrot
sox
spicetify-cli
spotify
sxhkd

# 支持键盘操作的GUI文件浏览器
- thunar
# -- 默认包不显示缩略图，安装 tumbler 显示缩略图
# -- 一些其他文件的缩略图支持
# @vedio ：ffmpegthumbnailer
# @PDF   ：poppler-glib
#----------------------------
# 支持移动设备自动挂载需要额外的包
# @gvfs
# @gvfs-mtp
# @gvfs-afc


wmctrl
wpgtk
xclip
xdotool
xprintidle
xwinfo

sysstat
```

#### 22. 合成器
- [AlexNomadrg/picom-animations: A lightweight compositor for X11](https://github.com/AlexNomadrg/picom-animations)
- [awarewen/dots-2.0: eww + bspwm rice c:](https://github.com/awarewen/dots-2.0)
这个分支的合成器和上流采用合并



#### 23.屏幕亮度背光  
```sh
yay -S light

# 在sxhkd 配置中修改brightlight 为
sudo light -A 5
sudo light -U 5


# light 和 dots-2.0中的通知脚本配置
```
brightlight (弃用)
- [multiplexd/brightlight](https://github.com/multiplexd/brightlight)
和脚本(.bscripts/brightness.sh)配合控制背光


### 切换内核
linux-lts linux-lts-headers
驱动 intel: xf86-video-intel
nvidia-lts
声音驱动 gpd匹配的
usbmuxd -usb设备驱动

## 记录LVM移除卷
创建 pv - vg - lv
移除 lv - vg - pv
如果移除时提示 read-only ：mount -o remount,rw -a (mount -o remount rw /) 以可读写的方式重新挂在所有设备
>
> partprobe 同步硬盘更改
wipefs 擦除分区filesystem标记


- [use KVM on pocket 3:Pocket 3 linux: Start kvm module with VLC : GPDPocket ](https://www.reddit.com/r/GPDPocket/comments/sd0pjs/pocket_3_linux_start_kvm_module_with_vlc/)

### 关于安装更新时遇到'PGP signature 'marginal trust' errors blocking upgrade'\
[ PGP signature 'marginal trust' errors blocking upgrade / Newbie Corner / Arch Linux Forums](https://bbs.archlinux.org/viewtopic.php?id=280650)\
```
rm -rf /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux archlinuxcn
pacman -Syy
```
如果还是有问题，请检查系统时间是否正确
`# timedatectl set-ntp 1`
`# hwclock --systohc`

#### zsh 
`# sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting zsh-completions   `
- Z-shell
- zsh-zi-mode

#### git && github && ssh key
[Generating a new SSH key and adding it to the ssh-agent - GitHub Docs](https://docs.github.com/cn/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
```sh
# 检查 ssh 服务是否运行
systemctl status sshd

# 创建ssh 密钥，用于Git操作GitHub远程仓库
ssh-keygen -t ed25519 -C "your_enmail@example.com"

eval "$(ssh-agent -s)"

# 添加已创建的私钥(默认名称)
ssh-add ~/.ssh/id_ed25519

# 最后将公钥添加到 GitHub 设置中
## 测试
ssh -T git@github.com

# 实现多个密钥的加载，需要在.zshrc中添加
eval "$(ssh-agent -s)" &> /dev/null
ssh-add ~/.ssh/id_ed25519 &> /dev/null
ssh-add ~/.ssh/id_2 &> /dev/null
```

####  软件/程序推荐
```sh
 #    桌面图形软件
-     ark       #       解压软件
-     dolphin   #       图形文件浏览器
-     telegram-desktop# 
#     >     需要去项目地址下载编译 

 #    终端下
-     fzf       #       信息过滤 配合fd / find / rg 等
-     fd        #       类似find 
-     tmux      #       终端复用
#     >     
-     neofetch  #       系统信息打印
-     autojump  #       路径跳转
-     ranger    #       文本文件浏览器
#     编辑器
-     Emacs     #       支持多功能拓展的终端编辑器
      >DOOM Emacs
      >
-     vim/vi/neovim#    终端下专注于编辑的富文本编辑器
      >SpaceVim

-     go-musicfox #     网易云
#     >     需要beep 这个包支持引擎
 
-     cava      #       音乐动画

 #    功能支撑
-     ntfs-3g   #       挂载ntfs文件格式硬盘
-     fcitx5    #       输入法支持
-     grub-custiomizer# 修改grub菜单启动界面
```

#     npm 安装
#     配置国内源

##    终端下代理（仍然存在问题，暂时放弃此方案）
```sh
#     kitty终端下
#     添加:
      export http_proxy=127.0.0.1:20171
      export https_proxy=127.0.0.1:20170
      export all_proxy=127.0.0.1:20171
#     @all_proxy 是为了让curl也能走代理

#     Tip
#     如果在删除 proxy 取消设置环境变量不起作用 请用 unset 命令
      unset http_proxy
```

####  SpaceVim
```sh
      curl -sLf https://spacevim.org/install.sh | bash -s -- -h
```

####  记录好看的 dotfile
- [ayamir/bspwm-dotfiles: My Arch+Bspwm dotfiles](https://github.com/ayamir/bspwm-dotfiles)

- [rxyhn/tokyo: BSPWM - Aesthetic Dotfiles 🍚](https://github.com/rxyhn/tokyo)

- [ikz87/dots-2.0: eww + bspwm rice c:](https://github.com/ikz87/dots-2.0)

- [owl4ce/dotfiles: Aesthetic OpenboxWM Environment](https://github.com/owl4ce/dotfiles)

####  firefox主题更改计划
####  终端美化
####  vim/neovim

####  电源管理
后续准备更新到tlp而不使用acpi
```sh
└─# nano /etc/tlp.conf
CPU_SCALING_GOVERNOR_ON_AC=powersave 
CPU_SCALING_GOVERNOR_ON_BAT=powersave
CPU_ENERGY_PERF_POLICY_ON_BAT=power
CPU_BOOST_ON_AC=1 
CPU_BOOST_ON_BAT=0
PLATFORM_PROFILE_ON_AC=performance 
PLATFORM_PROFILE_ON_BAT=low-power
DISK_IOSCHED="mq-deadline"
PCIE_ASPM_ON_AC=default 
PCIE_ASPM_ON_BAT=powersupersave
```
#
####  所有待解决问题  
- 在bspwm桌面使用eww暂时无法正常获取cpu使用情况
- 无法自动旋转
- firefox触控不正常
- 手写笔还未尝试

#### 修复合盖后休眠
