## ZI shell 终端工具链
WIKI:[⚡️ 安装 | Z-Shell](https://wiki.zshell.dev/zh-Hans/docs/getting_started/installation)

## ZI install
- 最小化安装 minimal : `sh -c "$(curl -fsSL get.zshell.dev)" --`
- loader  : `sh -c "$(curl -fsSL get.zshell.dev)" -- -a loader`
- Repository : `sh -c "$(curl -fsSL get.zshell.dev)" -- -i skip`
- Annex : `sh -c "$(curl -fsSL get.zshell.dev)" -- -a annex`
- ZUnit : `sh -c "$(curl -fsSL get.zshell.dev)" -- -a zunit`

## plagin list:
-- z-shell/z-a-meta-plugins : 元包
- - @annexes+ @zsh-users+fast  @fuzzy
-- romkatv/powerlevel10k : 主题
-- jeffreytse/zsh-vi-mode : 更好的 vi 快捷键
-- cantino/mcfly : 历史命令搜索
-- z-shell/zsh-zoxide : 历史路径跳转

## zsh-vi-mode options (URL:https://github.com/jeffreytse/zsh-vi-mode#custom-escape-key)
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

## zoxide
需要另外下载 'zoxide' 依赖

## [🌀 Annexes | Z-Shell](https://wiki.zshell.dev/ecosystem/category/-annexes)
这个 meta 包中包含了大部分插件需要的基础依赖

## "z-shell/F-Sy-H": Zsh 功能丰富的语法高亮显示, 可用于替换 "zsh-syntax-highlighting"
-- 此插件包含在了 meta 中的 "@zsh-users+fast"

单独添加的话
````
    zi wait lucid for \
        atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
         z-shell/F-Sy-H \
        blockf \
         zsh-users/zsh-completions \
        atload"!_zsh_autosuggest_start" \
         zsh-users/zsh-autosuggestions
````

