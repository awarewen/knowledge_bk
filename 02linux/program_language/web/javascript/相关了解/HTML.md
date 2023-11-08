# HTML
[HTML basics - Learn web development | MDN --- HTML 基础知识 - 学习 Web 开发 |MDN网络](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/HTML_basics)

- HTML 基础知识
    HTML (HyperText Markup Language，超文本标记语言) 是用于构建网页及其内容的代码。

- What is HTML
    更加详细来说，HTML 是一种标记语言，用于定义内容的结构。HTML 由一系列元素组成，使用这些元素来包围或包装内容的不同部分，以使其以某种方式显示或以某种方式运行。

- Anatomy of an HTML element: HTML 元素剖析
以下段落元素，将内容包裹在段落标签中来指定它是一个段落
`<p class="editor-note">My cat is very grumpy.</p>`

    1. 开始标记：由一对尖括号包裹元素名称 (p) 组成。这表示元素的开始或开始生效的位置: `<p>`
    2. 结束标记：由一对，尖括号包裹正斜杠 (/) 和元素名称 (p) 组成。这表示了元素的结束位置: `</p>`
    3. 内容：元素的内容
    4. 基本元素：开始标记+结束标记+内容=元素
    5. 元素的可选属性：属性包含有关不会出现在实际内容中的元素的额外信息，属性名称 `class`、属性值 `editor-note`。某些属性没有值 (required)。属性特性与元素或上一个属性之间空格分隔，属性名称后跟等号 (:)，由双引号包裹的属性值。

- Nesting element: 嵌套元素
可以将元素放入到其他元素中，元素之间应该保持正确的打开和关闭顺序
`<p>My cat is <strong>very</strong> grumpy.</p>`

    1. 错误的嵌套元素打开和关闭顺序将会导致未知行为

- Void element: `Void` 元素
`Void` 元素没有内容 (e.g. `img`)
`<img sec="images/firefox-icon.png" alt="my test image" />`
    
    1. 其中包含了两个属性，但是并没有单独的 `</img>` 结束标记，也没有内容。这是因为 `img` 元素不会包装内容来影响它，仅是将图像嵌入到 `HTML` 页面中出现的位置

