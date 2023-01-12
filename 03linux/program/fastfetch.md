# fastfetch
- [dylanaraps/pfetch: 🐧 A pretty system information tool written in POSIX sh.](https://github.com/LinusDierheimer/fastfetch)

用C语言实现的neofetch，速度很快

## kitty终端
kitty使用zlib协议显示图像

## 使用

```sh
    fastfetch --logo /PATH/TO/FILE --logo-width NUM --logo-height NUM
    # 长宽选其中一个另一项则按比例缩放，没有指定长宽则按原始尺寸显示
```


## 在kitty和tmux一起使用是出现错误
- [Support TIOCGWINSZ · Issue #1391 · tmux/tmux](https://github.com/tmux/tmux/issues/1391)

kitty 的 icat，允许在终端中显示图像，需要 ioctl 的支持 TIOCGWINSZ. 另见 kovidgoyal/kitty#413

