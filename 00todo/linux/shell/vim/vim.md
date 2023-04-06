# vim 学习
vim 是一个文本编辑器，可以追溯到qed。
- vim 模态编辑
vim 坚持模态编辑哲学，vim 提供多种模式，每个按键的意义根据不同的模式变化

## vim 基本
- 缓冲区(buffers)
vim 是一个文本编辑器。 文本显示在 buffer 中，每个文件都拥有自己的 buffer ，插件也在自己的 buffer 中显示一些提示。

buffers 拥有许多的属性，例如 buffer 中的文本是否可以修改，是否与文件相关联需要同步保存到磁盘中

- 窗口(windows)
windows 是 buffer 的显示窗口。

- 选项卡(tabs)
tabs 是 windows 的集合

- 快捷键映射
常见的6种映射模式

|递归  |非递归  |取消映射|模式
|------|--------|--------|----
|`map` |noremap |unmap 	 |normal,visual,operator-pending
|`nmap`|nnoremap|nunmap	 |normal
|`xmap`|xnoremap|xunmap	 |visual
|`cmap`|cnoremap|cunmap	 |command-line
|`omap`|onoremap|ounmap	 |operator-pending
|`imap`|inoremap|iunmap  |insert


`:nmap`是属于递归映射
```
# 设置b 返回一个 "Foo"
:nmap b :echo "Foo"<cr>

# 将b 最终返回一个字符串的行为 映射到 a
:nmap a b
这样在执行 a 的时候就会返回一个字符串
当取消 b 的映射时，a 的行为也会跟随 b 改变

# 使用非递归映射
:noremap a b
a 的行为则继承 b 的默认行为
```
应该始终使用非递归映射，除非递归映射的结果是实际上需要的
