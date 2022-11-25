# btrgs 详解
[系统管理员指南 - btrfs Wiki](https://btrfs.wiki.kernel.org/index.php/SysadminGuide#Subvolumes)
cow 写时复制，最开始发布在 2007，采用GPL开源
支持快照和增量快照
对子卷进行快照

snapper 快照管理

## 子卷
[Linux Btrfs 文件系统使用指南 | 米V米](https://www.mivm.cn/linux-btrfs-usage-guide/)
1. default 子卷(顶级子卷，根卷)
根卷在文件系统被格式化时就被创建
subvolid 为 5
可以借由 subvolid 为根卷创建快照

btrfs分区的默认子卷
2. 平行子卷
所有子卷创建在顶级子卷下
2. 嵌套子卷
类似目录树一样的结构，子卷下创建子卷
嵌套子卷在父卷被挂载后自动挂载
3. 混合子卷
平行子卷和嵌套子卷同时存在

### subvol && subvolid 
subvol 使用子卷的路径
subvolid 使用子卷id 子卷id 创建后是不变的

使用subvolid 挂载子卷的好处是即使子卷被移动后依旧可以正确挂载

### 子卷快照
-r 创建只读快照，只读子卷
### 透明压缩
创建子卷时添加 compress=lzo 参数(lzo压缩算法)

### btrfs 在线磁盘碎片整理

对于固态
计算机中对一个文件进行多次读写操作后会产生很多的碎片文件
btrfs 写时复制(COW)特性，原始数据将试图被扩展把新数据加入进来，如果进行碎片整理，文件系统下的新文件副本，
子卷和快照等等就丢失了，文件系统需要增加时间重新创建之前的副本，并且还需要扩展文件系统来完成这个过程
如果用户使用子卷或快照等功能建议不太其在线磁盘碎片整理
