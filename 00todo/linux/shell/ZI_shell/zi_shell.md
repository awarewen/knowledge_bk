## ZI shell
WIKI:[⚡️ 安装 | Z-Shell](https://wiki.zshell.dev/zh-Hans/docs/getting_started/installation)

## ZI install
```markdown
source <(curl -sL git.io/zi-loader); zzinit
# 短链失效了
source <(curl -sL https://raw.githubusercontent.com/z-shell/zi-src/main/lib/zsh/init.zsh); zzinit
```

## zsh-vi-mode (URL:https://github.com/jeffreytse/zsh-vi-mode#custom-escape-key)
### add in .zshrc
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
### use 'jk'
```
ZVM_VI_ESCAPE_BINDKEY: The vi escape key in all modes (default is ^[ => ESC)
ZVM_VI_INSERT_ESCAPE_BINDKEY: The vi escape key in insert mode (default is $ZVM_VI_ESCAPE_BINDKEY)
ZVM_VI_VISUAL_ESCAPE_BINDKEY: The vi escape key in visual mode (default is $ZVM_VI_ESCAPE_BINDKEY)
ZVM_VI_OPPEND_ESCAPE_BINDKEY: The vi escape key in operator pending mode (default is $ZVM_VI_ESCAPE_BINDKEY)
```
- ZVM_VI_INSERT_ESCAPE_BINDKEY=jk


## 全新的安装


