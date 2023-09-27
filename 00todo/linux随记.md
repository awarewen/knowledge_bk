## 电源节能
```sh
      /etc/default/grub
      _________________
      GRUB_CMDLINE_LINUX_DEFAULT="quiet splash intel_idle.max_cstate=1"
#     @ intel_idle.max_cstate=1
#     -- max_cstate这条指令会禁用CPU大部分可以执行的节能操作
#     -- 它可能会使笔记本的CPU温度出现问题，从而导致散热风扇一直处于高速运作的状态

#     > CPU 有一种叫做“C 状态”的东西。 状态“C0”（零）是内核正在运行和执行指令时的状态。
#     > 当内核无事可做时，操作系统将其置于“C1”，在那里它会休眠并等待硬件出现有事可做，然后内核再次开始工作。
#     > “C1”状态停止内核的时钟。 在“C1”一段时间后，CPU 将核心放入“C3”，然后是“C6”（在较新的 CPU 上更多）。 
#     > 在C3/C6状态下，CPU会开始为不同的部分断电。 大多数节电是在最后的 C 状态下完成的，而在 C1 中，它最多会降低电压但不会切断电源。
#     > 当你只是做网页浏览之类的事情时，CPU 90% 以上的时间都处于 C3/C6 状态。
-------------------------------------------------------------------------------------------------------------------------------
``` 
##  检查计算机启动时间
```sh
#     将引导过程表示为图片
      systemd-analyze plot > boot.svg
#     -- 可以生成一张名为 boot.svg 的文件，
#     -- 其中可以表现出对计算机启动时间影响比较大的进程
```

##  sysfs 内核数据虚拟接口
- [桌面应用|从 Linux 终端查看笔记本电池状态和等级的 5 个方法](https://linux.cn/article-10353-1.html)
```sh
#     系统内核虚拟的电源数据接口
      /sys/class/power_supply/BAT0/uevent
#     -- 待了解里面各项值的含义 
```

## How To Fix “unable to lock database” Error In Arch Linux
  `sudo rm /var/lib/pacman/db.lck`


## `zsh Shell` 中从 `.zlogin` 还是 `.zprofile` 启动wm
[Zsh - ArchWiki](https://wiki.archlinux.org/title/Zsh#Startup/Shutdown_files)
如果 zsh 配置目录 `$ZDOTDIR` 没有设置，则使用`$HOME`，并且如果没有在任何配置中设置 `RCS` 选项，则加载完最后的配置文件之后将不再读取任何其他配置文件

### `/etc/zsh/*` 通常用于为所有用户设置交互式 shell 配置和执行命令，在作为交互式 shell 启动时将被读取
- `/etc/zsh/zshenv` 全局的环境变量为所有的用户设置环境变量；它不应该包含生成输出的命令或假定外壳程序附加到 TTY 的命令。当文件存在时，它始终被读取，不能被覆盖。

- `/etc/zsh/zprofile` 用于 **启动时** 为所有用户执行的命令，启动时将作为 **login shell** 被读取，在 archlinux 上默认情况下它包含[一行](https://gitlab.archlinux.org/archlinux/packaging/packages/zsh/-/blob/main/zprofile) `source /etc/profile`
    - `/etc/profile` 此文件应该在 **登陆时** 由 **所有的 POSIX sh-compatible shell** source：它在 **登陆时** 设置 `$PATH` 和其他的环境变量以及特定于应用程序的 (`/etc/profile.d/*.sh`) 设置

- `/etc/zsh/zshrc` 用于设置所有用户 **interactive shell** 配置和执行命令，作为 **interactive shell** 启动时将被读取

-`/etc/zsh/zlogin` 在登陆时的初始化进度条结束时为所有用户执行命令，在启动时作为 **login shell** 被读取

### `$ZDOTDIR` 通常用于为当前用户
- `$ZDOTDIR/.zshenv` 用于设置当前用户的环境变量；它不应该包含生成输出或假定外壳程序附加到 TTY 的命令。当文件存在时，它始终被读取，不能被覆盖。

- `$ZDOTDIR/.zprofile` 用于在启动时执行用户的命令，在启动时作为 login shell 被读取。通常用于自启动图形会话和设置会话范围的环境变量

- `$ZDOTDIR/.zshrc` 用于设置当前用户的环境变量，在启动时作为 interactive shell 被读取。

- `$ZDOTDIR/.zlogin` 用于在初始进度结束时执行当前用户的命令，在 **启动时** 作为 **login shell** 被读取，通常用于自启动命令行实用程序。不作为自启动图形会话，因为此时的会话可能包含 **interactive shell** 的配置



## arch linux 孤包
- [pacman - Arch Linux 中文维基](https://wiki.archlinuxcn.org/wiki/Pacman)
- [到底什么是“孤立”包？Arch Linux 中文论坛](https://bbs.archlinuxcn.org/viewtopic.php?id=12252)


## 查看linux文件/文件夹大小 (du)
- [du 查看文件夹大小 — Linux latest 文档](https://gnu-linux.readthedocs.io/zh/latest/Chapter01/00_du.html)

````
-h, --human-readable    以K，M，G为单位，显示文件的大小
-s, --summarize         只显示总计的文件大小
-S, --separate-dirs     显示时并不含其子文件夹的大小
-d, --max-depth=N       显示子文件夹的深度（层级）
````

## PPPOE with NetworkManager
NM 需要额外的包(rp-pppoe)支持才能使用PPPOE/DSL

在添加后重启 NM 服务，可以使用 nm-connevyion-editor,也可以使用nmtui


## 在安装firefox插件沙拉查词遇到的问题
- [compression - "gzip: stdin has more than one entry--rest ignored" and "gzip: tmp.gz has more than one entry -- unchanged" - Super User](https://superuser.com/questions/1237854/gzip-stdin-has-more-than-one-entry-rest-ignored-and-gzip-tmp-gz-has-more-t)
- *.Zip 和 *.tar.gz
````
As explained by 'druuna' at http://www.linuxquestions.org/questions/linux-software-2/gunzip-%5Bfile%5D-has-more-than-one-entry-unchanged-618990/#post3047709, this can happen if it's actually a ZIP-file rather than a gz-file, just with a misleading extension, and it contains multiple files. (gzip -d does support ZIP-files that contain only one file.)

正如 http://www.linuxquestions.org/questions/linux-software-2/gunzip-%5Bfile%5D-has-more-than-one-entry-unchanged-618990/#post3047709 的“druuna”所解释的那样，如果它实际上是一个ZIP文件而不是gz文件，只是带有误导性的扩展名，并且它包含多个文件，则可能会发生这种情况。（ gzip -d 支持仅包含一个文件的 ZIP 文件。
````
可以使用 file 命令检查文件实际类型
将解压缩的命令更改为 unzip -d 可以工作


## tesseract 配合 pot-desktop 实现 ocr 识别并翻译
pot 有一个 'tesseract.js' 但是识别的效果和速度都不理想，而 arch linux 中可以安装本地的 tesseract 识别引擎，搭配对应语言的数据文件识别精度速度都成倍提升。
````
tesseract-data-chi_sim 中文简体
tesseract-data-eng     英语
````

## 串口连接
- tinyserial
提供了 `com` 命令
`Quidway s5700 series` 交换机
````
sudo com /dev/ttyUSB0 6900 (连接交换机)

$ system-view 进入配置模式(系统预览)
$ dis cu                  (配置预览)

## 1-22口做vlan 23 24口做双下联
$ vlan batch 101 to 124

$ interface 网卡名称0/0/1 (配置 1 号口)
$ port link-type access
$ port dafault vlan 101
$ quit
... 一直到22口
$ interface 网卡名称0/0/22 (配置 22 号口)
$ port link-type access
$ port dafault vlan 122
$ quit

$ interface 网卡名称0/0/23 (配置 23 号口)
$ port link-type trunk
$ port trunk allow-pass vlan 101 to 124
$ quit

$ interface 网卡名称0/0/24 (配置 24 号口)
$ port link-type trunk
$ port trunk allow-pass vlan 101 to 124
$ quit

$ quit  (退出配置模式)
$ save  (保存配置)

## 清除配置
$ reset saved-configuration
## 重启
$ reboot
````
