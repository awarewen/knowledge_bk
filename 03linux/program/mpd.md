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

    bind_to_address "127.0.0.1"
    port "6600"

    audio_output {
            #type          "alsa"
            #name          "ALSA sound card"
            type		"pipewire"
            name		"pipewire"
            #name		"Default ALSA Output (currently PipeWire Media Server)"
            #type            "pulse"
            #name            "pulse audio"
            #
      #device		"hw:15,0"	# optional
      #mixer_type      "hardware"	# optional
      #mixer_device	"default"	# optional
      #mixer_control	"PCM"		# optional
      #mixer_index	"0"		# optional 
            # Optional
            #device        "ALC269VC Analog,CARD=PCH,DEV=0"
            #mixer_control "PCM"
    }
```
- 使用systemctl --user 启动服务



