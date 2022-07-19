## 域名解析到指定ip的指定端口：

- 反代理类似分流

通过域名解析一般之解析到公网ip,并不能直接解析到指定的端口,想实现这种现已采用`反代理`,就是域名解析到公网ip后,再由nginx来将指定域名解析到其他地址或端口

```json
http {
  server {
      listen    80;
      proxy_set_header X-Real-IP  $remote_addr; # 这里可以记录远程访问ip，方便其他应用使用
      server_name xxx.com;
      location  / {
          proxy_pass    http://127.0.0.1:8080;
      }
  }

  server {  # 第二个Server对应第二个反代理
      listen    80;
      proxy_set_header  X-Real-IP $remote_addr;
      server_name xxx.cn;
      location  / {
          proxy_pass    http://127.0.0.1:8081;
      }
  }
}
```
