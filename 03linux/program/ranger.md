# ranger
终端下的文件管理器

- [ranger - ArchWiki](https://wiki.archlinux.org/title/Ranger)
- [Home · ranger/ranger Wiki](https://github.com/ranger/ranger/wiki)

## 配置
- 配置目录的结构，以及各个配置功能及作用
    - `rc.conf` - 主要包含键绑定和启动命令
    - `commands.py` - 默认的功能能函数和自定义的功能函数
    - `rifle.conf` - 启动不同类型的文件使用的应用程序

- 对于 `commands.py` 文件配置, 如果你将使用整个文件，请将下行命令添加到文件的顶部
 
 ```
 # 调用 ranger 的 api
   from ranger.api.commands import *
 ```

- 示例配置
  `Ranger` 可以自动复制默认配置文件到 `~/.config/ranger` 如果你用开关运行它 `--copy-config=( rc | scope | ... | all )`. 看 ranger --help有关该开关的说明

  `ranger --copy-config=all(~config/ranger)`


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
  # ～/.config/ranger/commands.py
  # _____________________________
    class set_wallpaper(Command):
        """:set_wallpaper <filename>

        set the system bg
        """

        def execute(self):
            # 优先检测 脚本文件是否存在
            conf_file_test = `~./.bscripts/wallset`
            if nott os.path.exists(conf_file_test):
                self.fm.notify("Wallset scripts not found!")
                return

            # 如果选中多个文件，只使用第一个文件设置壁纸
            target_filename = self.fm.thistab.get_selection()[0].path if len(self.fm.thistab.get_selection()) > 0 else None
            if not target_filename:
                # 获取当前文件的路径
                target_filename = self.fm.thisfile.path

            if not os.path.exists(target_filename):
                self.fm.notify("The given file does not exist!", bad=True)
                return
            # 应该优先检查路径是否存在，然后检查文件是否为图片

            try:
                # 检测所选文件是否为图片
                for file in self.fm.thistab.get_selection():
                    with open(file.path, 'rb') as f:
                        img = Image.open(f)
                        img.verify()
            except (IOError, OSError) as e:
                self.fm.notify(f"Selected file {file.basename} is not an image.", bad=True)
                return

            # 输出一条信息到底栏
            self.fm.notify("run commad: set_wallpaper " + target_filename)
            # 调用外部脚本程序
            self.fm.run('~/.bscripts/wallset ' + target_filename)
  # ---------------------------------------------------------------------------
  ```
