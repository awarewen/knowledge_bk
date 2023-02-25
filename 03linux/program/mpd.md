# 为当前用户安装mpd

  yay -S mpd

## 配置

 mpd 常用的两个配置位置：
 1. `～/.config/mpd/mpd.conf` :为系统的每个用户配置，而且优先于其他配置的位置
 2. `/etc/mpd.conf` :为整个系统的配置

## 为每个用户进行配置

### 拷贝示例配置文件
- `cp /usr/share/doc/mpd/mpdconf.example ~/.config/mpd/mpd.conf`

这些是一些最常用的配置选项：
  `pid_file`- MPD 存储其进程 ID 的文件
  `db_file`- 音乐数据库
  `state_file`- 这里记录了 MPD 的当前状态
  `playlist_directory`- 播放列表保存到的目录
  `music_directory`- MPD 扫描音乐的目录
  `sticker_file`- 贴纸数据库

```markdown
  ~/.config/mpd/mpd.conf
________________________
  下面是常用的配置选项:

    pid_file - MPD 存储进程 ID（PID）的文件
    db_file - 音乐数据库
    state_file - 记录 MPD 当前状态
    playlist_directory - 播放列表存储文件夹
    music_directory - MPD 在这个文件夹中扫描音乐
    sticker_file - 标签数据库
```
- 使用systemctl --user 启动服务
