# shell 入门
什么是shell

```sh
#!/bin/sh
cd ~
mkdir shell_tut
cd shell_tut

for ((i=0; i<10; i++)); do
        touch test_$i.txt
done
```
- `#!/bin/sh`: 指定脚本解释器，这里是用/bin/sh做解释器
- `cd mkdir`: 是系统命令，可以在脚本中调用
- `for do done`: 是sh脚本语言的关键字

## 脚本解释器
- sh
- bash
- fish
- zsh

理论上一门语言提供了解释器（不仅是编译器），这门语言就可以胜任脚本编程，常用的解释型语言都可以用作脚本编程的。
如： Perl, Tcl, Python, PHP, Ruby。 编译型语言，只要有解释器，也可以用作脚本编程，如C Shell是内置的(/bin/csh)。

## 变量
### 定义变量
不加美元符号（$）：
- 显示直接赋值
```sh
your_name="qinjx"
```
注意，变量名和等号之间不能有空格

- 语句扶植给变量
```sh
for file in `ls /etc`
```

- 使用变量
```sh
your_name="qinjx"
echo $your_name
echo ${your_name} # 这里的花括号可选，加花括号是为了帮助解释器识别变量的边界
```

### 字符串
  shell编程中最常用数据类型的是字符串，字符串可以用单引号，也可以用双引号，也可以不用引号。
  
> 单引号字符串的限制
>> 按引号里的任何字符都会原样输出，单引号字符串中的变量是无效的
>> 单引号字符串中不能出现单引号，使用转义符也不行

> 双引号
>> 字符串中可以出现变量
>> 可以出现转义字符
