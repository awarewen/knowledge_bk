# `pacman` 

Arch Linux 的包管理器

- 跳过某个软件/程序更新
```sh
/etc/pacman.conf
________________
```

# 孤包

sudo pacman -Rns $(pacman -Qtdq)

## fix: pacman is currently in use
This error message is as a result of unfinished jobs of pacman/yaourt hence making them locked in the previous tasked used in. Pacman/yaourt is locked in a uncompleted task when it has been canceled or you lost internet connection.

`rm /var/lib/pacman/db.lck`
