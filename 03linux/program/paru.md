# 多线程编译
  paru 包管理器默认使用 `/etc/makepkg.conf` 中的 `MAKEFLAGS='-jx'` 变量启用相应的多线程编译模式

`/etc/makepkg.conf` 中的 `MAKEFLAGS` 后，再设置 `YAY_MAKEFLAGS` 环境变量通常是没有必要的。
这是因为 `Paru` 会使用默认的 `MAKEFLAGS` 值来编译软件包，除非在 `Paru` 命令中显式指定了其他的 `MAKEFLAGS` 选项。否则 `Paru` 将会自动使用这些选项进行编译，而不需要再次设置 YAY_MAKEFLAGS 环境变量。

`Paru` 会优先使用指定的选项而不是 `/etc/makepkg.conf` 中的选项。在这种情况下，可能需要设置相应的 YAY_MAKEFLAGS 环境变量来确保 Paru 使用正确的编译选项。

## 关于多线程编译
  通常来说，建议将 MAKEFLAGS 设置为处理器线程数的两倍左右。这样可以充分利用多线程编译的优势，同时避免过度使用系统资源导致系统不稳定或编译效率下降。

