# 双系统
## windows
ventoy 
windows11 iso
进入到windows分区界面后，shift+f10 进入命令行模式
diskpart 分区命令
list disk
select disk 0
clean
convert gpt
create partition efi size=1024 (efi 选择1G是为了安装双系统)
create partition msr size=128 (windows 必须要的分区)
create partition primary size=153600 (150G 主分区C盘)
exit
exit （退出命令行）
出来之后刷新分区，选择主分区即可正常安装系统

> 尤其要记住在启动时要选择 UEFI 模式启动u盘否则在支持UEFI启动的主板上可能出现无法正常读取硬盘的情况。
windows 在分区中已有 efi分区时不会新创建efi分区
