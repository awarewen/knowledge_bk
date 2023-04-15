# polybar 配置

## future
- [模块输出长度超过时覆盖中断](https://github.com/polybar/polybar/issues/395)

## [bar/xx]中指定字体索引
需要注意polybar从用户目录中搜寻指定字体。
```
[bar/xx]
font-0 = "iosevka:pixelsize=12;0"
```
然后以以下方式配置给模块使用
```
[module/xx]
label-font = 1

```
### TIP
- border-size 和radius-(top,bottom)不应该一起使用，因为边框不会被圆角化

## [global/xx]
全局的一些定义

## [bar/xx]
bar 栏目相关的定义

## [module/xx]
模块首先定义类型，然后才是对于的参数选项
### Type
- custom/type
  - text
  - scripts
### 语法
- format-NAME (format 包含了label,progress bars,ramps,animations)
模块的外观主要是format决定的
label-NAME = foobar
format-online = ...
format-offline = ...

##  多个[bar/xx]
- 使用 inherit 继承状态
[inherit](https://github.com/polybar/polybar/wiki/Configuration#inheritance)
提供更高的可能性，不同的bar和配置分离
```
[bar/main]
...


[bar/top]
inherit = bar/main
offset-y = 10
modules-center = sep launcher sep workspaces sep cpu sep memory sep mpd sep alsa sep battery sep network sep date sep sysmenu sep
enable-ipc = true
```



##  module 模块设置
[module-setting]( https://github.com/polybar/polybar/wiki/Configuration#module-settings )

- type: (来源/模块类型)

## applaction settings
``
[settings]
; The throttle settings lets the eventloop swallow up til X events
; if they happen within Y millisecond after first event was received.
; This is done to prevent flood of update event.
;
; For example if 5 modules emit an update event at the same time, we really
; just care about the last one. But if we wait too long for events to swallow
; the bar would appear sluggish so we continue if timeout
; expires or limit is reached.
```


```
;文本类型的模块
[module/sep]
;;类型定义
type = custom/text
;; 模块内容
content = |
;; 这个模块作用是作为分隔不同的模块
;; 类似的是separator选项，但是这是用在[BAR]里面的选项
; The separator will be inserted between the output of each module
; separator = |
; 如果是要在自定义的模块内部使用的话应该使用
; label-separator = |

```


# info-cava插件
- [polybar-scripts/polybar-scripts/info-cava at master · polybar/polybar-scripts](https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/info-cava)

```
[module/info-cava]
type = custom/script
exec = ~/polybar-scripts/info-cava.py -f 24 -b 12 -e fffdfc,fffafe,ffeafa,ffc3d2 -c average
tail = true
```


## my bar
创建自己的bar

- 采用一个主要配置，然后将模块配置分割出去

- 多屏幕支持[]
- bar创建 []
