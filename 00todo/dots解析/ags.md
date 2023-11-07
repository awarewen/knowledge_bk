# ags 配置方法

## 安装
- install
`yay -S aylurs-gtk-shell # or aylurs-gtk-shell-git`

- source
```
# clone, build, install
git clone --recursive https://github.com/Aylur/ags.git
cd ags
npm install
meson setup build
meson install -C build
```

## 配置
- 先决条件 javascript

### JavaScript
配置中插入分号是可选的，因为有自动插入分号

# ags 作者配置解析

# notifications
- 解决问题
    缓存问题
    作者应该是将所有的通知保存到文件后读入内存，或者读入内存再保存到文件

- dunst 没问题
