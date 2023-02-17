# 文件浏览器
Thunar 是 Xfce 桌面环境的模块化的现代文件管理器
# 安装
```sh
# for archlinux
    yay -S thunar

# from github
    git clone https://gitlab.xfce.org/xfce/thunar
    git checkout <branch|tag>  #optional step. Per default master is checked out
    cd thunar
    ./autogen.sh
    make
    make install
    
# from release tarball
    tar xf thunar-<version>.tar.bz2
    cd thunar-<version>
    ./configure
    make
    make install

```

# 拓展功能
Thunar 插件可以作为单独的附加包安装，以扩展 Thunar 的功能。 大多数 Thunar 插件在上下文菜单中或通过快捷方式提供文件的附加选项

- Bulk Renamer
- Custom Actions :批量文件重命名
- Archive Plugin (thunar-archive-plugin) :
- Media Tags Plugin (thunar-media-tags-plugin)
- Shares Plugin (thunar-shares-plugin)
- Volume Manager (thunar-volman)
- VCS Plugin (thunar-vcs-plugin)
