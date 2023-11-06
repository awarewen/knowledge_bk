# 这是一个对《dots-2.0》配置的整体解析
- 原配置仓库地址：[ikz87/dots-2.0: eww + bspwm rice c:](https://github.com/ikz87/dots-2.0)\
  **非常感谢 ikz87 同学的rice。**

  本文基于以下基础条件讲解：
  ```
  OS:       Arch Linux

  WM:       bspwm
  ```

  这篇文章将会从每个文件的作用和配置方式以及使用方法来尽可能的带大家入门到掌握这份配置文件。

## 配置的目录结构
![Folder_Tree](./Images/Folder_Tree.png)
### `.bscripts`
1. `.bscripts` 目录中存放了这份配置扩展的各个功能的脚本调用实现，简单来说，这个目录存放的脚本是用来实现某些功能的。
- `brightness.sh`: 是一个用于控制屏幕亮度的脚本。
- `bselect.sh`:
- `bsmove.sh`
- `colors.sh`
- `idle.sh`
- `lock.sh`
- `notif_sounds.sh`
- `rofi.sh`
- `ss.sh`
- `toggle_bar.sh`
- `toggle_winprops.sh`
- `volume.sh`
- `wallset`
- `winevents.sh`
- `wpg-install.sh`
- `wpm_reports.sh`
2. `.cache`: 存放了配置文件产生的临时文件
3. `.config`: 存放了各个部件的所有配置项
  -
4. `.local`: 字体所在目录
5. `Documents`: 存放了音效文件
6. `Pictures`: 所有需要用到的图片文件
7. `install.sh`: 安装脚本

# 依赖
```sh
yay -Sy acpi alsa-utils-git blueman brave-bin bspwm
        colorpicker dunst eww-git flameshot hsetroot
        imagemagick jq kitty light mantablockscreen
        network-manager-applet pa-applet-git picom-ftlabs-git
        playerctl polkit-gnome polybar pulseaudio python3
        rofi scrot sox spicetify-cli spotify sxhkd sysstat
        thunar wmctrl wpgtk-git xclip xdotool xprintidle xwinfo-git --needed
```


### 背光方案采用 `light`
- 将当前用户添加到 ‘VIDEO’ 组，以获取到控制背光的权限(light)

```markdown
# 将用户添加到video组
    usermod -aG video <user>
```

## 私人配置

### 壁纸切换
  使用配置中的 '~/bscripts/wallset' 脚本设置壁纸

```sh
~/.bscripts/wallset PATH_TO_FILE
#_______________________________
```
- 添加ranger快捷键切换壁纸

```markdown
# 添加一个自定义命令
    # ～/.config/ranger/commands.py
    # _____________________________

      from __future__ import (absolute_import, division, print_function)
      from ranger.api.commands import Command
      from PIL import Image
      import os
      import errno

      class set_wallpaper(Command):
          """:set_wallpaper <filename>

          set the system bg
          """

          def execute(self):
              # 如果选中多个文件，只使用第一个文件设置壁纸
              target_filename = self.fm.thistab.get_selection()[0].path if len(self.fm.thistab.get_selection()) > 0 else None
              if not target_filename:
                  # 获取当前文件的路径
                  target_filename = self.fm.thisfile.path

              # 检查文件是否为图片
              try:
                  with Image.open(target_filename) as img:
                      # 解码图像文件并检查文件格式是否正确
                      img.verify()
              except (IOError, OSError) as e:
                  if e.errno == errno.ENOENT:
                      self.fm.notify("The given file does not exist!", bad=True)
                  else:
                      self.fm.notify(f"Selected file {os.path.basename(target_filename)} is not an image.", bad=True)
                  return

              # 输出一条信息到底栏
              self.fm.notify("run commad: set_wallpaper " + target_filename)
              # 调用外部脚本程序
              #self.fm.run('~/.bscripts/wallset ' + target_filename)
              self.fm.run('ln -sf ' + target_filename + ' ~/.config/rice_assets/Images/wallpaper.png')
              self.fm.run('bspc wm -r')
              self.fm.run('for wid in $(xdotool search --class eww); do xdotool windowunmap $wid; done')
              self.fm.run('for id in $(bspc query -N -n .leaf.\!window); do bspc node $id -k; done;')
    # -----------------------------------------------------------------------
    # @ self.fm.thisfile.path 获取当前选定的绝对文件路径
    # @ self.fm.notify 在ranger底栏显示一条信息
    # @ self.fm.run 运行一条命令，这里对wallset进行调用

    # 为自定义命令添加键位绑定
    # ~/.config/ranger/rc.conf
    # ______________________
      map xw set_wallpaper --fzf-select
      map xW set_wallpaper --choosefile --fzf-select
    # ----------------------
    # @ tw 可以选择一个不冲突的键位绑定
```

### 锁屏
- 使用了betterlockscreen 替换 mantablockscreen
betterlockscreen -l dim

- 使用
缓存图像：
    `mantablockscreen -i PATH/TO/IMAGE`

### 2023/1/12 弃用 `mantablockscreen` ，使用 `betterlockscreen` 代替
- [betterlockscreen/betterlockscreen: 🍀 sweet looking lockscreen for linux system](https://github.com/betterlockscreen/betterlockscreen#usage)
```markdown
# 在启动脚本中注释mantablockscreen
    ~/.config/bspwm/autostart
_____________________________
# Cache lockscreen 
# mantablockscreen -i ~/Pictures/Important/lockscreen.png&

# 安装
    yay -S betterlockscreen

# 依赖
    i3lock-color-git
    imagemagick
    feh (可选)
    xorg-xdpyinfo
    xorg-xrandr
    dunst (可选)

# 示例配置文件，如果不执行复制示例配置，将使用硬编码的配置(与示例配置相同)
    mkdir -p ~/.config/betterlockscreen/
    cp /usr/share/doc/betterlockscreen/examples/betterlockscreenrc ~/.config/betterlockscreen/

# 缓存图像：
    betterlockscreen -u /PATH/TO/IMAGE

# 更改配置脚本 
    ~/.bscripts/lock.sh
_______________________
    #!/bin/sh

    pkill -SIGUSR1 dunst # pause 
    # mantablockscreen 弃用
    #mantablockscreen -sc # requires https://github.com/reorr/mantablockscreen      
    betterlockscreen -l dim
    pkill -SIGUSR2 dunst # resume 
```


## 休眠

- P3 s3休眠已经在 6.1.5 内核修复
- 忽略合盖
```
  /etc/systemd/logind.conf
__________________________
  IdleAction=lock
  HandleLidSwitch=lock
```
