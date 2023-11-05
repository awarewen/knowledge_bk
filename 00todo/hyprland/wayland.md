## 当一个程序无法在wayland下打开图形界面
- [xserver - What are xhost and xhost +si? - Ask Ubuntu --- xserver - 什么是 xhost 和 xhost +si？- 询问 Ubuntu](https://askubuntu.com/questions/877820/what-are-xhost-and-xhost-si)
为了使用 Wayland 图形系统（而不是使用 X 窗口系统），您必须以这种方式向 root 用户添加权限：
`xhost +SI:localuser:root`
这样做，root 用户（或用作 airgeddon sudo）能够完美地检测屏幕分辨率。

