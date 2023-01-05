# DRM
  DRM 是 linux 内核层的显示驱动框架，他把显示功能封装成 open/close/ioctl 等标准接口
用户空间的程序调用这些接口，驱动设备，显示数据。

## libdrm framework
  libdrm 库封装了 DRM driver 提供的这些接口，通过 libdrm 库，程序可以间接调用 DRM Driver
