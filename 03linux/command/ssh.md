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
    ssh 'device_name@ip'

#   生成一对密钥
    ssh-keygen -f 'key_name'

#   将公钥发送到服务器
    ssh-copy-id -i ~/.ssh/'key_name.pub' 'device_name@ip'
#   -- 服务端将公钥存储在~/.ssh/authorized_keys
```
### 为每个key添加配置模板
```sh
#   修改sshd_config配置
    /etc/ssh/sshd_config 
    ____________________
    PermitRootLogin yes  
    StrictModes no
    PubkeyAuthentication yes
    AuthorizedKeysFile .ssh/authorized_keys
    PasswordAuthentication yes

#   为每个KEY添加ssh_config模板
    /etc/ssh/ssh_config
    ____________________
    Host  Github
      HostName github.com         #   服务地址
      User git                    #   使用名称
      IdentityFile ~/.ssh/id_rsa  #   私钥

#   将每个私钥添加到钥匙环
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa

#   如果还是不行请检查密钥的文件权限
#   @ '.ssh' 权限为 '700'
#   @ 'authorized_key' 权限为 '600'
#   -- 这是为了防止除了密钥的拥有用户外的其他用户更改密钥文件
```
