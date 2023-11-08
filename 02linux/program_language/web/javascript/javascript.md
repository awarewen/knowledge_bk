# site
- [Lexical grammar - JavaScript | MDN --- 词汇语法 - JavaScript |MDN网络](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar#automatic_semicolon_insertion)

## 完全初学者入门
- Getting started with the web
    - Installing basic software
        1. `vscode`: 代码编辑
        2. `browsers`: 测试代码
    - What will your website look like
        在编写之前需要对网站进行规划和设计
        1. 网站是关于什么的
        2. 图文内容
        3. Themes
        可以粗略的勾勒一个整体布局情况
        草图 -> 数字模型 -> web页面
    - Dealing with files
        网站由许多文件组成，需要在本地计算机上将这些文件组成一个合理的结构。
        1. 以小写形式命名文件夹和文件，不带空格
            *. 在计算机中尤其是服务器是区分大小写的。
            *. 浏览器、web服务器和编程语言无法一致的处理空格。（最好使用连字符分隔，而不是下划线）
        2. 网站结构
            *. `index.html`: web 主页内容
            *. `images/`: 存放网站上使用的图像
            *. `styles/`: 将包含用于设置内容样式的 `CSS` 代码
            *. `script/`: 将包含用于网站交互功能的所有的 `JavaScript` 代码
    - HTML basics

- Setup a local testing server

    - Local files vs. Remote files
        一般情况下我们通过直接在浏览器中打开示例. 如果浏览器地址栏的 `web` 地址是 `file://` 开头，后面跟 `Hard Drive` 上的文件路径，则是本地文件。
        如果是 `http://` 或者 `https://` 开头则是远程服务器上的文件。

    - The probelm with testing local files
        如果将某些示例作为本地文件打开，则他们无法运行。
            1. 它们具有异步请求。如果只是从本地文件运行示例，则某些浏览器 (include `Chrome`) 不会运行异步请求 (see: https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Fetching_data)。这是一种安全限制 (see: https://developer.mozilla.org/en-US/docs/Learn/Server-side/First_steps/Website_security)
            2. 它们采用服务器端语言 (PHP Python)，需要一个特殊的服务器来解释代码并交付结果
            3. 它们包括了其他文件。浏览器通常将使用 `file://` 架构加载资源的请求视为跨域请求，因此如果加载包含其他本地文件的本地文件，则可能触发 `CORS` 错误
