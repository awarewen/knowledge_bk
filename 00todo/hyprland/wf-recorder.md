# 使用 wf-recorder 实现类似web 网页投屏功能
- https://github.com/ammen99/wf-recorder/issues/167

-- 1
Is there any way to use wf-recorder to cast my screen via HTTP? I was thinking perhaps the output could be piped via SSH to a publicly accessible video file... I haven't gotten that far yet, since even locally, the output file of wf-recorder -f myout.mp4 cannot be played before wf-recorder is closed.
有什么办法可以通过 wf-recorder HTTP投射我的屏幕吗？我在想，也许输出可以通过 SSH 管道传输到可公开访问的视频文件......我还没有走到那一步，因为即使在本地，在关闭 wf-recorder 之前也无法播放输出 wf-recorder -f myout.mp4 文件。

Any ideas whether this could be done somehow? Screencasting soltuions for wayland tend to either not work or be quite convoluted, it would be really great if this could be done with a few chained bash commands.
任何想法是否可以以某种方式完成？wayland 的截屏解决方案往往要么不起作用，要么非常复杂，如果这可以通过一些链接的 bash 命令来完成，那就太好了。

-- 1 R
You can output to v4l2 (virtual camera, search for v4l2loopback) with the following command:
您可以使用以下命令输出到 v4l2（虚拟摄像机，搜索 v4l2loopback ）：

`yes | wf-recorder -t --muxer=v4l2 --codec=rawvideo --pixel-format=yuv420p --file=/dev/video0`

Where /dev/video0 is the virtual device created by v4l2. This works for screen sharing in web apps like jitsi, so you can probably build on top of this.
其中 /dev/video0 是 v4l2 创建的虚拟设备。这适用于 jitsi 等 Web 应用程序中的屏幕共享，因此您可以在此基础上进行构建。

-- 2
@git-bruh I have tried that workaround for videoconferencing, but is there any way to do this without that extra bit of potentially unreliable infrastructure? (among other things web apps will messes up the resolution and apply compression formats which might be good for faces but not for text)
我已经尝试了视频会议的解决方法，但是有没有办法在没有额外的潜在不可靠基础设施的情况下做到这一点？（除其他外，Web 应用程序会弄乱分辨率并应用压缩格式，这可能对面部有好处，但对文本不利）
Can I just select a remotely accessible file to upload to via SSH? What would be the formats that would allow viewing a file which is actively being written to?
我可以只选择一个远程访问的文件通过 SSH 上传到吗？允许查看正在写入的文件的格式是什么？

-- 2 R
This is only lightly tested but I am able to stream desktop to html page with v4l2loopback. Here's what worked for me:
这只是经过轻微测试，但我能够使用 v4l2loopback 将桌面流式传输到 html 页面。以下是对我有用的东西：

Assumptions: 假设：

    apache or some way to serve a webpage
    apache 或某种方式为网页提供服务
    ffmpeg installed 已安装 ffmpeg
    v4l2loopback module installed
    已安装 v4l2loopback 模块
    wf-recorder installed 已安装 WF-Recorder
    the web server is running on the same machine running wayfire
    Web 服务器在运行 Wayfire 的同一台计算机上运行

Insert the following html:
插入以下 html：
Head: 头：

````
<link href="https://vjs.zencdn.net/7.2.3/video-js.css" rel="stylesheet">
````

Body: 身体：

````
<video id='video-stream' class="video-js vjs-default-skin center" width="640" height="480" controls>
        <source type="application/x-mpegURL" src="streams/desktop-stream1.m3u8">
</video>
````

Scripts: 脚本：
````
<script src="https://vjs.zencdn.net/ie8/ie8-version/videojs-ie8.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/videojs-contrib-hls/5.14.1/videojs-contrib-hls.js"></script>
<script src="https://vjs.zencdn.net/7.2.3/video.js"></script>
<script>
    var player = videojs('video-stream');
    player.play();
</script>
````

where 'streams/desktop-stream1.m3u8' is a path relative to the html file. Then, setup the video stream by running these commands:
其中 'streams/desktop-stream1.m3u8' 是相对于 HTML 文件的路径。然后，通过运行以下命令来设置视频流：

sudo modprobe v4l2loopback exclusive_caps=1 card_label=desktop_view1
wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video2 -x yuv420p -t
ffmpeg -i /dev/video2 -an /var/www/website/streams/desktop-stream1.m3u8

At this point, you should be able to refresh the page and play the video.
此时，您应该能够刷新页面并播放视频。
