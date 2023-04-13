# polybar 配置

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

- 多屏幕支持[]
- bar创建 []
