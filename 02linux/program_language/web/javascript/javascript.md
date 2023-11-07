# site
- [Lexical grammar - JavaScript | MDN --- 词汇语法 - JavaScript |MDN网络](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar#automatic_semicolon_insertion)

## 完全初学者入门
- Getting started with the web
    - Installing basic software
        1. vscode: 代码编辑
        2. browsers: 测试代码

- Setup a local testing server

    - Local files vs. Remote files
        一般情况下我们通过直接在浏览器中打开示例. 如果浏览器地址栏的 `web` 地址是 `file://` 开头，后面跟 `Hard Drive` 上的文件路径，则是本地文件。
        如果是 `http://` 或者 `https://` 开头则是远程服务器上的文件。

    - The probelm with testing local files
        如果将某些示例作为本地文件打开，则他们无法运行。
            1. 它们具有异步请求。如果只是从本地文件运行示例，则某些浏览器 (include `Chrome`) 不会运行异步请求 (see: https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Fetching_data)。这是一种安全限制 (see: https://developer.mozilla.org/en-US/docs/Learn/Server-side/First_steps/Website_security)
            2. 它们采用服务器端语言 (PHP Python)，需要一个特殊的服务器来解释代码并交付结果
            3. 它们包括了其他文件。浏览器通常将使用 `file://` 架构加载资源的请求视为跨域请求，因此如果加载包含其他本地文件的本地文件，则可能触发 `CORS` 错误
