## [login shell and interactive](https://zsh.sourceforge.io/Guide/zshguide02.html)
在首次登陆计算机时 shell 是 interactive shell ，但它同时也是一个 login shell

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
