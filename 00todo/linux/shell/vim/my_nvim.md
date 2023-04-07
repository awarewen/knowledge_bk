# 从0开始的NeoVim生活
- [mhinz/vim-galore: All things Vim!](https://github.com/mhinz/vim-galore#buffers-windows-tabs)

<!---->
## 重要参考
- NvChad
  [DOC | NvChad](https://nvchad.com/)

- LazyVim
  [DOC | LazyVim](https://www.lazyvim.org/)

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
- 多种配置的融合归纳

- 重要的功能应该在三个快捷键程之内完成（prefix + 1 + 2) 最大的编辑效率
- 块标记
- 更合理的通知效果（通知分级，弹出，读取，忽略）
- 提示、消息、错误,清屏

- 外部交互

- 工程管理
