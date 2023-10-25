# Eww - widgets for everyone!
    Eww 是使用 Rust 制作的小部件系统，它允许你创建自己的小部件，独立于窗口管理器 (window manager)
    使用 CSS 进行配置和主题

## Writing your eww configuration
    Eww 使用 yuck 进行配置，一种类似于 lisp 的 S-expressions 语言

    所有的样式是使用 CSS 或 SCSS 定义，Eww 依赖于 GTK 的 CSS 引擎，但是某些动画功能以及大多数与布局相关的 CSS 属性不支持

## Simple expression language

Example:
````
(box
    "Some math: ${12 + foo * 10}"
    (button :class {button_active ? "activel" : "inactive"}
            :onclick "toggle_thing"
        {button_active ? "disable" : "enable"}))
````

- Features
    - 简单的数学运算 (+, -, *, /, %)
    - 比较 (==, !=, >, <, <=, >=)
    - 布尔运算 (||, &&, !)
    - 正则表达式 (=~)
    - elvis (?:) [如果左侧是 "" 或者 JSON null，则返回右侧，否则计算到左侧]
    - 安全访问运算符 (?.) or (?.[index]) [左侧 "" 或 JSON null，则返回 null，否则尝试编制 index。 如果左侧存在但不是对象，可能会导致错误 ( Number or String)]
    - 条件 (condition ? 'value' : 'other value')
    - 数字，字符串，布尔值，变量引用
    - JSON 访问 (object.field, array[12], object["field"]) [对象/数组需要引用包含有效 JSON 字符串或变量]
    - Function calls
        - round(number, decimal_digits): 将数字四舍五入到给定的小数位数
        - sin(number), cos(number), tan(number), cot(number) 计算给定数字的三角值（以弧度为单位）
        - degtorad(number): 将数字从度数转换为弧度
        - radtodeg(number): 将数字从弧度转换为度
        - replace(string, regex, replacement): 替换字符串中给定正则表达式的匹配项
        - search(string, regex): 在字符串中搜索给定的正则表达式 （返回数组）
        - matches(string, regex): 检查给定字符串是否与给定的正则表达式匹配（返回布尔值）
        - captures(string, regex): 获取字符串中给定正则表达式的捕获 （返回数组）
        - strlength(value): 获取字符串的长度
        - substring(string, start, length): 返回从给定索引开始的给定长度的子字符串
        - arraylength(value): 获取数组的长度
        - objectlength(value): 获取对象中的条目数量
        - jq(value, jq_filter_string): 对 JSON 值运行 jq 样式命令，（内部使用jaq）
        - formtime(unix_timestamp, format_str, timezone): 从 UNIX 时间戳中获取给定格式的时间
        - formtime(unix_timestamp, format_str): 从 UNIX 时间戳中获取给定格式的时间，不接受时区，使用系统的本地时区


## widgets list

- combo-box-text: 允许用户在多个项目之间进行选择的组合框
- expander: 可以展开和折叠的小部件，显示/隐藏其子项
- revealer: 可以通过动画显示子项的小部件
- a checkbox: 可以在选中/未选中时触发事件的复选框
- color-button: 打开颜色选择器的窗口按钮
- color-chooser: 颜色选择器小部件
- scale: 滑块
- progress: 进度条
- input: 输入字段，要求 set focusable="true" on the window
- button: 按钮
- image: 显示图像
- box: 主布局容器
- overlay: 将其子项放在彼此之上的小部件，叠加微件的大小与其第一个子项的大小相同
- centerbox: 一个必须正好包含三个子项的容器，这些子项将布置在容器的开头，中心和结尾
- scroll: 具有可滚动的单个子项的容器
- eventbox: 可以接受事件必须只包含一个子项的容器
- label: 文本小部件，显示文本
- calendar: 显示日历的小部件
- transform: 将其内容应用转换的小部件，控制旋转和偏移
- circular-progress: 显示圆形进度条的小部件
- graph: 显示给定值如何随时间变化的图形的小部件

## Magic variables
    这些变量始终都存在，无需导入
    - EWW_TIME 更新间隔时间为 1S
    - 其他所有的变量更新时间间隔为 2S

- EWW_TEMPS: 热量（摄氏度）
- EWW_RAM: RAM和Swap 使用情况（单位：KB）
- EWW_DISK: 有关所有挂在分区的信息(Btrfs和zfs 上不准确)
- EWW_BATTERY: 电池容量
- EWW_CPU: CPU内核信息（不支持 MacOS）
- EWW_NET: 网络信息
- EWW_TIME: 当前 UNIX 时间戳
- EWW_CONFIG_DIR: 当前进程的 Eww 配置的路径
- EWW_CMD: 当前配置中运行的 Eww 命令，在事件处理中很有用
- EWW_EXECUTABLE: Eww 可执行文件的完整路径
