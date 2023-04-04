# 安装
[jeffreytse/zsh-vi-mode: 💻 A better and friendly vi(vim) mode plugin for ZSH.](https://github.com/jeffreytse/zsh-vi-mode#custom-escape-key)
1. 包管理
```sh
    yay -S zsh-vi-mode
```

2. zinit plugin manager
```sh
    zinit ice depth=1
    zinit light jeffreytse/zsh-vi-mode
```
3. 配置
```sh
#   .zshrc
    ZVM_VI_INSERT_ESCAPE_BINDKEY=jk # 启用jk快捷切换模式
    ZVM_VI_SURROUND_BINDKEY=classic # 环绕模式
    ZVM_KEYTIMEOUT=0.5 #按键等待时间
```
