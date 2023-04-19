# 从0开始的NeoVim生活
- [mhinz/vim-galore: All things Vim!](https://github.com/mhinz/vim-galore#buffers-windows-tabs)

<!---->
## 重要参考
- NvChad
  [DOC | NvChad](https://nvchad.com/)

- LazyVim
  [DOC | LazyVim](https://www.lazyvim.org/)
  - 添加 `jk` 快捷键
  ```
  -- `~/.config/LazyVim/lua/config/keymaps.lua`
  vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })
  ```
  - 添加 `mini.misc` 使用其中的 `zoom` 功能

- SpaceVim
  [DOC | SpaceVim](https://spacevim.org/)
  
- LunarVim
  [DOC | LunarVim](https://www.lunarvim.org/)

## plugins
- lazy.nvim
- maeson.nvim
## install lazy.nvim
```markdown
- 创建配置目录
mkdir `~/.config/nvim`
mkdir `~/.config/nvim/lua`
touch `~/.config/nvim/init.lua # 整个配置的入口文件`

```
 

## 结构
nvim/
├── init.lua # 入口
├── lazy-lock.json # 插件版本管理
├── LICENSE # 许可
├── lua/ # config dir
│   ├── config
│   │   ├── ...
│   └── plugins
│       └── ...
├── README.md
└── stylua.toml

Todo..
- 多文件编辑，多窗口组织
- 更加合理的快捷键探索
- 配置管理的探索，多份配置的管理，多份配置之间更方便的插件迁移机制
在neovim 0.9.0 版本已经实现
每份配置的文件应该存在于~/.config/配置名称目录
不同的配置应该有不同的名称
```
# nvim
alias lazyvim="NVIM_APPNAME=LazyVim nvim"
#alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias chadvim="NVIM_APPNAME=NvChad nvim"
#alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias spacevim="NVIM_APPNAME=SpaceVim nvim"

function nvims() {
  items=("default" "LazyVim" "NvChad" "SpaceVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
```
- 多种配置的融合归纳

- 重要的功能应该在三个快捷键程之内完成（prefix + 1 + 2) 最大的编辑效率
- 块标记
- 更合理的通知效果（通知分级，弹出，读取，忽略）
- 提示、消息、错误,清屏

- 外部交互

- 工程管理

- 文件夹之间的跳转

- nvim窗口之间的快速跳转，屏幕之间的快速跳转，终端窗口之间的快速跳转，tmux 窗口之间的快速跳转 统一且容易记忆的快捷键标准
