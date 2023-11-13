# 引子
hyprctl 的所有命令输出支持json格式，可以使用 jq 进行解析

[Parsing JSON with jq --- 使用 jq 解析 JSON](http://www.compciv.org/recipes/cli/jq-for-parsing-json/)
[jq Manual (development version) --- jq手册（开发版）](https://jqlang.github.io/jq/manual/)
## 调用，参数
- 调用规则
````
Unix shells: jq '.["foo"]'
Powershell:  jq '.[\"foo\"]'
windows command shell: jq ".[\"foo\"]"
````
Note:
    jq 允许用户定义函数，但是每个 `jq` 程序都必须要有一个顶级表达式

- 命令行参数
    - `--null-input / -n`   : 不读取输入，筛选器运行一次，用做`null`输入
    - `--raw-input / -R`    : 不将输入解析为 JSON，每行文本作为字符串传递给筛选器，结合 `--slurp` 将整个输入作为单个长字符串传递给筛选器
    - `--slurp / -s`        : 不要为输入中的每个 JSON 对象运行筛选器，将整个输入流读入一个大型数组，并之运行一次筛选器
    - `--compact-output / -c`: 将每个 JSON 对象放于一行，产生更紧密的输出
    - `--raw-output / -r`   : 筛选器输出结果是字符串，则写入标准输出，而不是格式化带双引号的 JSON 字符串

## 过滤器 `.`

