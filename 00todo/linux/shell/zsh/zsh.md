# Zsh shell 简单了解

> 原文地址：知乎 —— "https://zhuanlan.zhihu.com/p/28887846"

## 格式约定

`%` - 命令提示符
`>` - 换行后的输入内容
`#` - 注释
其余内容为输出内容，成段的 `zsh` 代码将省略开头的 `%`。

## 变量

`zsh` 有5种变量：整数、浮点数(bash不支持)、字符串、数组、哈希表

### 变量定义

zsh 的变量在大多数情况下不需要提前声明或者指定类型，可以直接赋值和使用（哈希表例外）

# 等号两端不能有空格
% num1=123
% num2=123.456
% str1=abcde

# 如果字符串中包含空格等特殊字符，需要加引号
% str2='abc def'

# 也可以用双引号，但和单引号有区别，双引号中可以使用变量，单引号中不可以
% str3="abc def $num1"

# 在字符串中可以使用转义字符，单双引号均可
% str4="abc\tdef\ng"

# 输出变量，也可以用print
% echo $str1
abcde

# 简单的数值运算
% str=abcdef

# 2 和 4 都是字符在数组的位置，从1开始计算，逗号两边不能有空格
% echo $str[2,4]
bcd

# -1 是最后一个字符
% echo $str[4,-1]
def
```

### 变量比较

```zsh
# 数值比较
% num=123

# (()) 用于数值比较，真返回0,否则为1
# && 后面的语句在前面的语句为真才执行


## zshenv

### .zshenv
始终处于source。它通常包含应该可供其他程序使用的导出变量。
例如:
- $PATH
- $EDITOR
- $PAGER
通常设置为 .zshenv 中。此外，您可以在 .zshenv 中设置 $ZDOTDIR ，为其余的 zsh 配置指定备用位置。


## .zprofile 用于登录外壳。它与 .zlogin 基本相同，只是它的来源在 .zshrc 之前，而 .zlogin 的来源在 .zshrc 之后。根据 zsh 文档，“ .zprofile 是 ksh 粉丝 .zlogin 的替代品;这两者不打算一起使用，尽管如果需要，这当然可以做到。


 .zshrc 用于交互式 shell。您可以使用 setopt 和 unsetopt 命令在此处设置交互式 shell 的选项。您还可以加载 shell 模块、设置历史记录选项、更改提示、设置 zle 和完成等。您还可以设置仅在交互式 shell 中使用的任何变量（例如 $LS_COLORS ).


.zlogin 用于登录外壳。它来源于登录 shell 的开头，但在 .zshrc 之后，如果 shell 也是交互式的。此文件通常用于使用 startx 启动 X。某些系统在启动时启动 X，因此此文件并不总是很有用。

.zlogout 有时用于清除和重置终端。它在退出时调用，而不是在打开时调用。
```

- [GitHub - SixArm/zsh-config: SixArm.com → Z shell → zsh configuration](https://github.com/SixArm/zsh-config)
zshenv -> zprofile -> zshrc (current)
zshenv   : always
zprofile : if login shell
zshrc    : if interactive shell
zlogin   : if login shell, after zshrc
zlogout  : if login shell, after logout

