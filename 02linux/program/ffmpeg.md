# FFmpeg

## 视屏切片
  ffmpeg -y -1 video/path/a.mp4 path/to/save/%04d.png
  -@ '-y' 覆盖图片
## 切片合成
  ffmpeg -y -framerate 25 -1 path/to/images/%04d.png path/to/save/a.mp4

## 转换
## crf 压缩质量

ffmpeg -i D:\src.mov -c:v libx264 -preset veryslow -crf 18 -c:acopy D:\dest1.mp4
