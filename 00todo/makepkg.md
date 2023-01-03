# PKGBUILD
PKGBUILD 是一个 shell 脚本，包含 Arch Linux 在构建软件包时需要的信息。

Arch Linux 用 makepkg 创建软件包。当 makepkg 运行时，它会在当前目录寻找 PKGBUILD 文件，
并依照其中的指令编译或获取所需的依赖文件，并生成 pkgname.pkg.tar.zst 软件包。
生成的包内有二进制文件和安装指令，可以使用 pacman 进行安装。
