## ZI shell 终端工具链
WIKI:[⚡️ 安装 | Z-Shell](https://wiki.zshell.dev/zh-Hans/docs/getting_started/installation)

## ZI install
- 最小化安装 minimal : `sh -c "$(curl -fsSL get.zshell.dev)" --`
- loader  : `sh -c "$(curl -fsSL get.zshell.dev)" -- -a loader`
- Repository : `sh -c "$(curl -fsSL get.zshell.dev)" -- -i skip`
- Annex : `sh -c "$(curl -fsSL get.zshell.dev)" -- -a annex`
- ZUnit : `sh -c "$(curl -fsSL get.zshell.dev)" -- -a zunit`

## zsh-vi-mode options (URL:https://github.com/jeffreytse/zsh-vi-mode#custom-escape-key)

## zoxide

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

## cantino/mcfly BUG 修复 (未修复)
- [thread 'main' panicked at 'McFly error: Please ensure HISTFILE or MCFLY_HISTFILE is set · Issue #313 · cantino/mcfly · GitHub](https://github.com/cantino/mcfly/issues/313)

- [Ensure at least MCFLY_HISTFILE is set for history import by cantino · Pull Request #315 · cantino/mcfly · GitHub](https://github.com/cantino/mcfly/pull/315)

- 需要注意脚本中设置的`MCFLY_HISTFILE`变量和当前存储历史的文件名称是否一样
