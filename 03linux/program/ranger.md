# ranger
终端下的文件管理器

- [ranger - ArchWiki](https://wiki.archlinux.org/title/Ranger)
- [Home · ranger/ranger Wiki](https://github.com/ranger/ranger/wiki)

## 配置
- 配置目录的结构，以及各个配置功能及作用
    rc.conf - 主要包含键绑定和启动命令
    commands.py - 默认的功能能函数和自定义的功能函数
    rifle.conf - 启动不同类型的文件使用的应用程序

rc.conf 文件默认已包含了 `commands.py`, `rifle.conf` . For commands.py, if you do not include the whole file, put this line at the top:
 

from ranger.api.commands import *

- 示例配置
  `Ranger` 可以自动复制默认配置文件到 `~/.config/ranger` 如果你用开关运行它 `--copy-config=( rc | scope | ... | all )`. 看 ranger --help有关该开关的说明

  `ranger --copy-config=command(~config/ranger)`


- 图片预览
  预览存在多种方案，因为我的终端使用的是kitty所以默认设置即可

- 插件
  'xoxide' 对于 'ranger' 的第三方的支持: 'ranger-zoxide'

- 自定义命令
  1. 'ranger-zoxide' 快捷键修改
  ```
  ~/.config/ranger/rc.conf
  map cz zi #使用'cz'替代默认的'zi'快捷键
  ```

  2. 调用自定义的功能函数
  所有的功能函数定义在 `~/.config/ranger/command.py`
  ```markdown
    ～/.config/ranger/commands.py
_________________________________
    class set_wallpaper(Command)
        def execute(self):
            if self.arg(1):
                target_filename = self.rest(1)
            else:
                target_filename = self.fm.thisfile.path
            self.fm.notify("run command: set_wallpaper " + target_filename)
            self.fm.run('~/.bscripts/wallset ' + target_filename)
---------------------------------------------------------------------------
    # @ self.fm.thisfile.path 获取当前选定的绝对文件路径
    # @ self.fm.notify 在ranger底栏显示一条信息
    # @ self.fm.run 运行一条命令，这里对wallset进行调用
  ```

