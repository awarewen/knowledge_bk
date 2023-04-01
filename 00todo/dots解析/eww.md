# EWW
- [Configuration - eww documentation --- 配置 - eww 文档](https://elkowar.github.io/eww/configuration.html)
Eww（ElKowar 的 Wacky Widgets，发音时带有足够的厌恶情绪）是一个用 Rust 制作的小部件系统，它允许您创建自己的小部件，就像在 AwesomeWM 中一样。关键区别：它独立于您的窗口管理器
EWW 拥有自己的配置语言 `yuck` ，`yuck` 基于 `S` 表达式，类似于 `lisp`
`vim/nvim` 使用 `yuck.vim` 获取编辑器支持

> 这里创建Eww bar的思路是这样的
1. 多种情况讨论
  - 只有一个连接的屏幕
    当只有一个连接的屏幕时，要求显示主bar: tray,time && date,system statu,workspace,music player,desktop layout switch
  - 有两个连接的屏幕
    当有2个已连接的屏幕时，对主bar进行拆分，
  - 有两个以上的屏幕

## Eww 小部件
### 小部件支持的所有特性
- class:string :css 类名
- valign:string :垂直对齐方式:("fill 填充","baseline 基线","center 中心","start 开始","end 结束")
- halign:string :水平对齐方式:("fill 填充","baseline 基线","center 中心","start 开始","end 结束")
- vexpand:bool :这个容器是否可以垂直扩展. Default:false
- hexpand:bool :这个小部件是否可以水平扩展.Default:false
- width:int ：这个元素的宽度，如果内容超出了限定宽度，这个宽度并不能限制其大小，会自动扩展
- height:int :这个元素的高度, 如果内容超出了限定宽度，这个宽度并不能限制其大小，会自动扩展
- active:bool :小部件是否可以交互
- tooltip:string ：鼠标悬停在小部件上时显示文本
- visible:bool :小部件的可见性
- style : string : 小部件的内联样式

### defwindow-properties 窗口属性
- monitor:窗口显示在哪个监视器
> 创建两个Eww窗口,并且分别在显示器1和显示器0，分别对应不同的显示器1和0
> monitor 属性：数字（X11 和 Wayland），直接填写名称仅限X11
```yuck
(defwindow example
           :monitor 1
           :geometry (geometry :x "0%"
                               :y "20px"
                               :width "90%"
                               :height "30px"
                               :anchor "top center")
           :stacking "fg"
           :reserve (struts :distance "40px" :side "top")
           :windowtype "dock"
           :wm-ignore false
  "example content")

(defwindow example_0
           :monitor 0
           :geometry (geometry :x "0%"
                               :y "20px"
                               :width "90%"
                               :height "30px"
                               :anchor "top center")
           :stacking "fg"
           :reserve (struts :distance "40px" :side "top")
           :windowtype "dock"
           :wm-ignore false
  "example content")

```

- geometry-properties

```
           :geometry (geometry :x "0%"
                               :y "20px"
                               :width "90%"
                               :height "30px"
                               :anchor "top center")

```

## combo-box-text

## 不同分辨率下的eww
分辨率调整缩放比例


- 配置解析
eww.yuck : 配置Eww

eww.scss ：配置主题

要解决这个问题需要从scss入手


- 提供模板
- 外部外部脚本直接切换模板
- 内部
