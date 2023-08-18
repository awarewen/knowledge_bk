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
