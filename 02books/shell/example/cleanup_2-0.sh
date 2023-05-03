#!/bin/sh
#
##Cleanup,version 2.0

# Run as root,of course.

LOG_DIR=/var/log
# 使用变量优于直接使用硬编码
cd $LOG_DIR

cat /dev/null > message
cat /dev/null > wtmp

echo "Logs cleaned up."

exit #正确推出脚本的方法
     #返回一个无参数的exit
