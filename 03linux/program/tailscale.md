# tailscale
- [laisky-blog: 近期折腾 tailscale 的一些心得](https://blog.laisky.com/p/tailscale/)
- [Tailscale 基础教程：Headscale 的部署方法和使用教程 – 云原生实验室 ](https://icloudnative.io/posts/how-to-set-up-or-migrate-headscale/)

## WireGuard
wireguard 中的每个节点都会存储其他所有节点的信息，并和其他所有的节点都建立
tls连接。如果涉及到内网穿透的话，那就需要一台处于网关位置的节点，内外网都可达
将其设置为coordinator，扮演一个类似hub的角色，分发穿透内外网的流量。

> 缺点
- 配置繁琐
- 维护困难，增加删除节点都需要改动所有节点的配置

## tailscale
1. 在原有的ICE，STUN 等 UDP 协议外，实现了 DERP TCP 协议来实现 NAT 穿透
2. 基于公网的 corrdinator 服务器下发 ACL 和配置，实现节点动态更新
3. 通过第三方(google) SSO 服务生成用户和私钥，实现身份认证。

简而言之，tailscale 可以理解为更为易用，封装更完善的 wireguard

### tailscale 能做什么
只要机器可以连接到公网，tailscale 可以让所有机器连接到同一个私有子网内。

1. 传输文件
tailscale 内置了 taildrop 可以在设备间传输文件，tailscale是一个全平台的软件。

2. 远程开发

3. 代理 （有点麻烦暂时不考虑）

## tailscale 会和 git抢占端
这就造成了git push clone pull 等操作失败
