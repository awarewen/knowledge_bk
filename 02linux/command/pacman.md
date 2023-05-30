# `pacman` 

Arch Linux 的包管理器

- 跳过某个软件/程序更新
```sh
/etc/pacman.conf
________________
```

# 孤包

sudo pacman -Rns $(pacman -Qtdq)
