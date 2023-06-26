.zshenv

.zprofile 用于登录外壳。它与 .zlogin 基本相同，只是它的来源在 .zshrc 之前，而 .zlogin 的来源在 .zshrc 之后。根据 zsh 文档，“ .zprofile 是 ksh 粉丝 .zlogin 的替代品;这两者不打算一起使用，尽管如果需要，这当然可以做到。


 .zshrc 用于交互式 shell。您可以使用 setopt 和 unsetopt 命令在此处设置交互式 shell 的选项。您还可以加载 shell 模块、设置历史记录选项、更改提示、设置 zle 和完成等。您还可以设置仅在交互式 shell 中使用的任何变量（例如 $LS_COLORS ).


.zlogin 用于登录外壳。它来源于登录 shell 的开头，但在 .zshrc 之后，如果 shell 也是交互式的。此文件通常用于使用 startx 启动 X。某些系统在启动时启动 X，因此此文件并不总是很有用。

.zlogout 有时用于清除和重置终端。它在退出时调用，而不是在打开时调用。

- [GitHub - SixArm/zsh-config: SixArm.com → Z shell → zsh configuration](https://github.com/SixArm/zsh-config)
````
zshenv -> zprofile -> zshrc (current)
zshenv   : always
zprofile : if login shell
zshrc    : if interactive shell
zlogin   : if login shell, after zshrc
zlogout  : if login shell, after logout
````

## ZSH 配置管理

zshenv : 通常放置一些每个 zsh 需要的一些环境变量
    Set up the command search path
    设置命令搜索路径

    Other important environment variables
    其他重要的环境变量

    Commands to set up aliases and functions that are needed for other scripts
    用于设置其他脚本所需的别名和函数的命令

- What does NOT go in it:(里面没有的东西)

    Commands that produce output
    生成输出的命令

    Anything that assumes the shell is attached to a tty
    任何假定外壳附加到 tty 的东西
