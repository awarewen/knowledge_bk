## vscode 安装
- yay -S code code-features code-marketplace

## wayland 模式启动 添加 flags
- 由于code 不使用系统的Electron版本，而是打包了一个Electron在包里面，为code启用wayland支持:
````
~/.config/code-flags.conf
_________________________
--enable-features=WaylandWindowDecorations
--ozone-platform-hint=wayland
--enable-wayland-ime
````
