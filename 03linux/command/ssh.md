#   ssh连接服务端
```sh
#   ssh 连接服务器超时断线时间延长
    /etc/ssh/sshd_config
    ____________________
    ClientAliveInterval 60 #超时时间
    ClientAliveCountMax 3 #尝试次数
```
##  连接服务器
```sh
#   连接到服务器
    ssh device_name@ip

#   生成一对密钥
    ssh-keygen -f key_name

#   将公钥发送到服务器
    ssh-copy-id -i ~/.ssh/key_name.pub device_name@ip
#   -- 服务端将公钥存储在~/.ssh/authorized_keys
```
### 现在仍然存在问题
```sh
#   在将ssh公钥发送给服务端后仍然需要输入密码
    /etc/ssh/sshd_config 
    ____________________
    PermitRootLogin yes
    PasswordAuthentication yes
    StrictModes no
    PubkeyAuthentication yes 
#   按照上述服务端配置检查

#   如果还是不行请检查密钥的文件权限
#   @ '.ssh' 权限为 '700'
#   @ 'authorized_key' 权限为 '600'
#   -- 这是为了防止除了密钥的拥有用户外的其他用户无法更改密钥文件

#   最后检查客户端的私钥文件是否被添加到钥匙环中
    eval "$(ssh-agent -s)"
    ssh-add '私钥'
```
