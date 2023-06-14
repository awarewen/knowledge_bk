## ZI shell 终端工具链
WIKI:[⚡️ 安装 | Z-Shell](https://wiki.zshell.dev/zh-Hans/docs/getting_started/installation)

## ZI install
安装前提是终端需要挂上代理否则更新失败
- 最小化安装 minimal : `sh -c "$(curl -fsSL get.zshell.dev)" --`
- loader  : `sh -c "$(curl -fsSL get.zshell.dev)" -- -a loader`
- Repository : `sh -c "$(curl -fsSL get.zshell.dev)" -- -i skip`
- Annex : `sh -c "$(curl -fsSL get.zshell.dev)" -- -a annex` 
- ZUnit : `sh -c "$(curl -fsSL get.zshell.dev)" -- -a zunit`


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

## plagin list:
- Use meta-plugins to install common annexes as a group:
-- z-shell/z-a-meta-plugins
-  - @annexes @zunit @zsh-users  @fuzzy
-- z-shell/F-Sy-h
-- z-shell/H-S-MW
-- z-shell/z-a-eval
-- romkatv/powerlevel10k
-- jeffreytse/zsh-vi-mode
-- jeffreytse/zsh-vi-mode
-- cantino/mcfly

## Annexes
- [🌀 Annexes | Z-Shell](https://wiki.zshell.dev/ecosystem/category/-annexes)

### bin--gem-node
[🌀 Bin Gem Node | Z-Shell](https://wiki.zshell.dev/ecosystem/annexes/bin-gem-node)


### Meta工具
- [🌀 Meta Plugins | Z-Shell](https://wiki.zshell.dev/ecosystem/annexes/meta-plugins)
附件中的元包安装
```sh taital:~/.zshrc
zi light z-shell/z-a-meta-plugins
```
附件自动应用了精选的最佳 ice-modifiers 列表。

> annexes
> > 


