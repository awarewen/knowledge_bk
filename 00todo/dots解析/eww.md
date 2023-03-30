# EWW
- [Configuration - eww documentation --- 配置 - eww 文档](https://elkowar.github.io/eww/configuration.html)
Eww（ElKowar 的 Wacky Widgets，发音时带有足够的厌恶情绪）是一个用 Rust 制作的小部件系统，它允许您创建自己的小部件，就像在 AwesomeWM 中一样。关键区别：它独立于您的窗口管理器
EWW 拥有自己的配置语言 `yuck` ，`yuck` 基于 `S` 表达式，类似于 `lisp`
`vim/nvim` 使用 `yuck.vim` 获取编辑器支持

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
-


## 不同分辨率下的eww
分辨率调整缩放比例


- 配置解析
eww.yuck : 配置Eww

eww.scss ：配置主题

要解决这个问题需要从scss入手


- 提供模板
- 外部外部脚本直接切换模板
- 内部
