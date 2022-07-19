问题描述
  删除了 `/usr/lib/node_modules` 文件夹，npm无法正常运行

解决方案

1. 通过 `pacman -Qk` 将缺少的文件找出来

    ```bash
    sudo pacman -Qk | tee qk.log
    ```

2. 排序找出缺失文件的程序

3. 把缺少文件的程序重新安装

