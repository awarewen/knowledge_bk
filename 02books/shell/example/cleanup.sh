#!/bin/sh

# Cleanup
# Run as root, of course.

# 先进入工作目录
cd /var/log

# 执行清空log操作
cat /dev/null > messagers
cat /dev/null > wtmp

# 返回信息
echo "Log files cleaned up."
