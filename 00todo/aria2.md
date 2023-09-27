# aria2
````
# 一个自动配置脚本
yay -S aria2-config-script
````

# 配置 '/etc/aria2/aria2.conf'

# systemd
`sudo systemctl enable --now aria2@$USER`


# pacman
使用多线程连接镜像服务器以提高下载速度，pacman 的 XferCommand 使用 aria2c 不会导致并行下载多个包。因为 Pacman 调用 XferCommand 时是一次一个包调用的，等待下载完成才会启动下一个
````
XferCommand = /usr/bin/aria2c --allow-overwrite=true --continue=true --file-allocation=none --log-level=error --max-tries=2 --max-connection-per-server=2 --max-file-not-found=5 --min-split-size=5M --no-conf --remote-time=true --summary-interval=60 --timeout=5 --dir=/ --out %o %u
````
