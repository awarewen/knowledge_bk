发送一个图像（或动画 gif）给守护进程显示。

使用“-”从标准输入读取

用法：swww img [OPTIONS] <PATH>

参数：
  <PATH>
          要显示的图像的路径

选项：
  -o, --outputs <OUTPUTS>
          用逗号分隔的输出列表显示图像。

          如果未设置，图像将显示在所有输出上。

          [默认值：]

      --no-resize
          不要调整图像大小。相当于`--resize=no`

          如果设置了此选项，图像将不会调整大小，并将居中显示在屏幕中央。如果小于屏幕尺寸，将使用下面的`fill_color`值填充。

      --resize <RESIZE>
          是否调整图像以及调整图像的方法

          [默认值：crop]

          可能的值：
          - no:   不要调整图像
          - crop: 调整图像以填满整个屏幕，裁剪掉不适合的部分
          - fit:  调整图像以适应屏幕内，保持原始纵横比

      --fill-color <FILL_COLOR>
          输出图像未填满屏幕时填充的颜色

          [默认值：000000]

  -f, --filter <FILTER>
          缩放图像时要使用的滤镜（运行 swww img --help 查看选项）。

          可用的选项有：

          Nearest | Bilinear | CatmullRom | Mitchell | Lanczos3

          这些选项由 fast_image_resize crate 提供（https://docs.rs/fast_image_resize/2.5.0/fast_image_resize/）。'Nearest' 是我推荐用于像素艺术的滤镜，仅限于像素艺术。它也是最快的滤镜。

          对于非像素艺术的内容，我通常建议使用最后三个之一，尽管可能需要一些实验来确定哪个是最喜欢的。还要注意它们都比 Nearest 慢。

          [默认值：Lanczos3]

  -t, --transition-type <TRANSITION_TYPE>
          设置过渡类型。默认为'simple'，淡入新图像

          可能的过渡效果包括：

          none | simple | fade | left | right | top | bottom | wipe | wave | grow | center | any | outer | random 角度。它控制擦除的角度
          'left'、'right'、'top'和'bottom'选项使过渡效果从该位置到屏幕的相反位置发生。

          'none'是'simple'的别名，还将'transition-step'设置为255。这会使过渡立即完成。

          'fade'类似于'simple'，但淡入由--transition-bezier标志控制

          'wipe'类似于'left'，但允许您使用`--transition-angle`标志指定过渡的角度。

          'wave'类似于'wipe'，扫过的线是波浪状的

          'grow'导致一个不断增长的圆圈在屏幕上过渡，并允许使用`--transition-pos`标志更改圆圈的中心位置。

          'center'是'grow'的别名，其位置设置为屏幕中心。

          'any'是'grow'的别名，其位置设置为屏幕上的随机点。

          'outer'与grow相同，但圆圈收缩而不是增长。

          最后，'random'将随机选择一个过渡效果

          [env: SWWW_TRANSITION=]
          [默认值：simple]

      --transition-step <TRANSITION_STEP>
          过渡效果接近新图像的速度有多快。

          过渡逻辑通过从当前RGB值中添加或减去值直到旧图像转换为新图像来工作。这控制我们添加或减去的量。

          较大的值将使过渡更快，但更突然。当过渡类型为'simple'时，该值默认为2，否则为90

          [env: SWWW_TRANSITION_STEP=]
          [默认值：90]

      --transition-duration <TRANSITION_DURATION>
          过渡效果完成所需的时间，以秒为单位。

          请注意，这不适用于'simple'过渡效果

          [env: SWWW_TRANSITION_DURATION=]
          [默认值：3]

      --transition-fps <TRANSITION_FPS>
          过渡效果的帧速率。

          请注意，将此值设置为小于您的显示器支持的值是没有意义的。

          还要注意，这与transition-step不同。那个控制我们每帧接近新图像的量。

          [env: SWWW_TRANSITION_FPS=]
          [默认值：30]


       --transition-angle <TRANSITION_ANGLE>
          用于'wipe'和'wave'过渡的角度。它控制擦除的角度

          请注意，角度以度为单位，其中'0'是从右到左，'90'是从上到下，'270'是从下到上

          [env: SWWW_TRANSITION_ANGLE=]
          [默认值：45]

      --transition-pos <TRANSITION_POS>
          仅用于'grow'、'outer'过渡。它控制圆圈的中心（默认为'center'）。

          位置值可以以百分比值和像素值的形式给出：浮点值解释为百分比，整数值解释为像素值，例如：
          0.5,0.5表示屏幕宽度的50%和屏幕高度的50% 200,400表示距左边200像素和距底部400像素

          该值还可以是别名，它将相应地设置位置：'center' | 'top' | 'left' | 'right' | 'bottom' | 'top-left' | 'top-right' |
          'bottom-left' | 'bottom-right'

          [env: SWWW_TRANSITION_POS=]
          [默认值：center]

      --invert-y
          反转'transiiton_pos'标志中的y位置

          [env: INVERT_Y=]

      --transition-bezier <TRANSITION_BEZIER>
          用于过渡的贝塞尔曲线 https://cubic-bezier.com 是获取这些值的好网站

          例如：0.0,0.0,1.0,1.0 用于线性动画

          [env: SWWW_TRANSITION_BEZIER=]
          [默认值：.54,0,.34,.99]

      --transition-wave <TRANSITION_WAVE>
          目前仅用于'wave'过渡，以控制每个波浪的宽度和高度

          [env: SWWW_TRANSITION_WAVE=]
          [默认值：20,20]

  -h, --help
          打印帮助（使用'-h'查看摘要）
          'left'、'right'、'top'和'bottom'选项使过渡效果从该位置到屏幕的相反位置发生。

