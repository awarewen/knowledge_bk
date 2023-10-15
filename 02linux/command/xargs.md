## xargs (eXtended ARGuments)
从标准输入构建和执行命令行参数
> 通俗将是给命令传递参数的过滤器，是一个组合多个命令的实用工具
> 在 linux 下有很多命令是不支持读取标准输入的,例如(echo)

## xargs 与 管道符的区别
linux 命令可以从两个地方读取输入，一个是通过命令行参数，一个是标准输入。
很多linux 命令设计是先从命令行参数中获取输入，然后从标准输入中读取
````
$ echo 'main' | cat test.cpp
cat: test.cpp: No such file or directory
````
这种情况下 cat 会输出 test.cpp 的内容，而不是 'main' 字符串，如果 test.cpp 不存在则 cat 命令报告该文件不存在,

## links
- [linux之xargs详解_xargs file-CSDN博客](https://blog.csdn.net/lovedingd/article/details/106554471)
- [xargs命令详解，xargs与管道的区别 - 五月的麦田](https://www.360blogs.top/xargs-cmd-and-pip/)
- [xargs(1): build/execute from stdin - Linux man page](https://linux.die.net/man/1/xargs)
- [Linux xargs 命令 | 菜鸟教程](https://www.runoob.com/linux/linux-comm-xargs.html)
