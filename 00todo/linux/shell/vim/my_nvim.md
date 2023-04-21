# 从0开始的NeoVim生活
- [mhinz/vim-galore: All things Vim!](https://github.com/mhinz/vim-galore#buffers-windows-tabs)
- 多种配置的融合归纳

各种配置，每个人的编写风格也不一样，从nvim lua guide开始学习

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
  如何安装

- SpaceVim
  [DOC | SpaceVim](https://spacevim.org/)
  
- LunarVim
  [DOC | LunarVim](https://www.lunarvim.org/)

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

