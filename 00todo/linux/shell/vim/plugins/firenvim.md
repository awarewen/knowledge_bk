# Home
- [glacambre/firenvim: Embed Neovim in Chrome, Firefox & others.](https://github.com/glacambre/firenvim)
About:
    Embed Neovim in Chrome, Firefox & others. Resources

# Install in 'echasnovski/nvim'
- add to path (download)
`git submodule add --name firenvim -b master  https://github.com/glacambre/firenvim.git pack/plugins/opt/firenvim`

- download all submodules and plugin
`git submodule update --init --filter=blob:none --recursive`

# call the plugin
- `nvim/lua/ec/packadd.lua`
````
packadd('firenvim')
````

# config
- 仅当在启动浏览器时使用此插件
`nvim/lua/ec/config/firenvim.lua`
````
if vim.g.started_by_firenvim ~= nil then
  vim.fn["firenvim#install"](0)
end
````


