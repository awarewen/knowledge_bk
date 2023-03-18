# C primer plus
## 第一章：C语言的前世今生
## 第二章：C语言概述
2.1：简单的C语言示例

```c
#include <stdio.h>

int main(void){
  //变量的定义以及赋值
  // int 字节一般为4字节，在不同字节的计算机中int 一般是2-4字节
  int num;
  num = 1;

  //函数调用
  //一般的函数都有返回值，用以判断该函数的执行状态
  printf("I am a simple ");
  printf("computer.\n");
  //%d取值符号，对应后面的参数列表
  printf("My favorite number is %d because it is first.\n",num);

  return 0;
}
```
