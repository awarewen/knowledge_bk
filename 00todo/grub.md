# grub炸了修复过程
1. 检察  fastab
2. 重新生成内核 mkinitpio -P 
3. 格式化 /boot，
4. 重新安装grub-install
5. 生成grub-mkconfig
6. reboot
