# 从0开始的NeoVim生活
- [mhinz/vim-galore: All things Vim!](https://github.com/mhinz/vim-galore#buffers-windows-tabs)

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
  ```
  -- `~/.config/LazyVim/lua/plugins/plugins.lua`
  {
      -- mini.nvim
    {
      "echasnovski/mini.nvim",

      config = {

        { -- mini.misc
          function()
            require("mini.misc").setup() --{ make_global = { "put", "put_text", "stat_summary", "bench_time" } }
          end,
        },
      },

      keys = {
        { -- mini.misc.zoom
          "<leader>wm",
          function()
            require("mini.misc").zoom()
          end,
          desc = "Zoom buf",
        },
      },
    },
  }
  ```

- SpaceVim
  [DOC | SpaceVim](https://spacevim.org/)

- LunarVim
  [DOC | LunarVim](https://www.lunarvim.org/)


-  echasnovski/nvim
  after/                       # 最后获取的所有内容 (`:h after-directory`)
   │ ftplugin/                 # 文件类型配置
   └ queries/                  # treesitter 查询
   lua/                        # 配置中使用的Lua代码
   ├ ec/                       # 自定义'插件命名空间'
   │ │ configs/                # 插件配置
   │ │ functions.lua           # 自定义函数
   │ │ mappings-leader.lua     # `<Leader>` 键的映射
   │ │ mappings.lua            # 映射
   │ │ packadd.lua             # 插件初始化代码
   │ │ settings.lua            # 通用设置
   │ └ vscode.lua              #VS Code相关配置
   └ mini-dev/                 # 'mini.nvim' 的开发代码
   misc/                       # 与 Neovim 启动没有直接关系的一切
   │ dict/                     # 字典文件
   │ mini_vimscript/           # Vimscript（重新）实现一些“迷你”模块
   │ scripts/                  # 杂用脚本
   │ sessions/                 # 本地使用 Neovim session 的占位符（忽略内容）
   │ snippets/                 # 片段引擎的片段
   └ undodir/                  # 本地使用持久撤销的占位符（忽略内容）
   pack/                       # 本地包管理器管理的插件/子模块的目录
   └ plugins/                  # 插件包名称
     └ opt/                    # 使用所有插件作为可选（需要手动 `packadd`）
   spell/                      # 拼写文件


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

vim.fn        更适合于对 VimL 函数进行简单的操作和调用，
vim.api       更适合于进行底层的 Vim 操作，例如修改选项、执行 Vim 命令等等

vim.opt       5.0版本及以上,替换以下三种vim变量访问方式,使用点运算符来访问选项，更加直观和易读。支持选项的类型推断，可以智能地转换选项的值。支持链式调用，可以快速地设置多个选项。
vim.o         用于表示普通选项（ordinary options），例如 autoindent、tabstop、number 等等。
vim.bo        用于表示缓冲区选项（buffer options），例如 textwidth、filetype、syntax 等等。
vim.go        用于表示全局选项（global options），例如 guifont、guioptions、termguicolors 等等。

## 同步滚动
[Scroll - Neovim docs --- 滚动 -](http://neovim.io/doc/user/scroll.html)
在显示多个窗口时，可以在每个窗口设置 `scrollbind` 选项，使多个窗口同时滚动。
````
:set scrollbind
````

## 光标跳跃效果
[Issues · edluffy/specs.nvim --- 问题 ·edluffy/specs.nvim](https://github.com/edluffy/specs.nvim)

## kickstart.nvim [A launch point for your personal nvim configuration](https://github.com/nvim-lua/kickstart.nvim)
采用lazynivm 作为插件管理器的配置
- 插件安装


## neovide 启动 env -u WAYLAND_DISPLAY neovide


## lazyvim start

### init.lua
- 一般的配置步骤：
    1. 确定 `leader`
        `mapleader` :作全局插件映射
        `maplocalleader` :作文件类型插件映射
        - NOTE: 两者不同的映射可以减少映射冲突的可能

