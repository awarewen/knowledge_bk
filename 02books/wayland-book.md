# wayland-book
Wayland 合成器的作用是调度输入，将事件发送给适当的 Wayland 客户端，并在其中显示他们的窗口，它们在您的输出中的适当位置。
- 汇集所有的过程在输出上显示的应用程序窗口称为合成——因此我们将执行此操作的软件称为合成器。


## linux 各个部分简介
- 在用户空间内应用程序与硬件隔离，需要通过内核提供的设备节点来工作
> libdrm :对于 linux内核层的显示驱动框 应用层代码库
>> 这是一个提供API的库

mesa
libinput
(u)udev
xkbcommon
pixman
libwayland
