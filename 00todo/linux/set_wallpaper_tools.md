# linux下设置壁纸
  有许多的工具都可以设置linux下的壁纸。
  但是这篇文章探讨的中心围绕着精巧简便，很重要的一点就是即时切换，性能优先。

## 测试环境
  这篇文章基于以下的硬件以及系统环境：
  - OS: Arch Linux
  - WM: bspwm

## 可用的程序列表
  - feh
  - hsetroot
  - xwallpaper

## 程序的使用以及脚本示例

1. feh
  一个轻量化、可配置和多功能的图像查看器。推荐配合使用 ImageMagick 提供的 convert 二进制文件。
- [GITHUB:derf/feh](https://github.com/derf/feh)
- [FEH_man](https://man.finalrewind.org/1/feh/)
```markdown

```
- feh 实现选择一个文件夹自动播放其中的图片设置为桌面背景

- [壁纸切换和设置 - 配置、脚本、教程和提示 - ArchLabs Linux](https://forum.archlabslinux.com/t/wallpaper-switching-and-setting/5490)
```sh
#!/bin/bash

# simple background setting for 1-2 monitors

SET_MON=0
NO_XINERAMA=''
SET_TYPE='scale'
MON1=''
MON2=''

GUI='' CHW='' SCRIPT_PATH="$0"

badarg()
{
	printf "error: additional arg required or improper arg passed.\n"
	exit 2
}

chwall()
{
	# update each monitor's wallpaper in the script
	case $SET_MON in
		0)
			MON1="$WALL_PATH"; MON2=""
			sed -i "/^MON2=.*/ c MON2=''" "$SCRIPT_PATH"
			sed -i "/^MON1=.*/ c MON1='${MON1}'" "$SCRIPT_PATH" ;;
		*)
			eval "MON${SET_MON}='$WALL_PATH'"
			sed -i "/^MON${SET_MON}=.*/ c MON${SET_MON}='${WALL_PATH}'" "$SCRIPT_PATH"
	esac

	# update the scaling type and xinerama
	sed -i "/^SET_TYPE=.*/ c SET_TYPE='${SET_TYPE}'" "$SCRIPT_PATH"
	sed -i "/^NO_XINERAMA=.*/ c NO_XINERAMA='${NO_XINERAMA}'" "$SCRIPT_PATH"
}

run()
{
	if [[ $MON1 && $MON2 ]]; then
		feh --no-fehbg --bg-$SET_TYPE "$MON1" "$MON2"
	elif [[ $MON1 ]]; then
		# shellcheck disable=SC2086
		feh $NO_XINERAMA --no-fehbg --bg-$SET_TYPE "$MON1"
	else
		printf "error: no monitors configured\n"
		return 1
	fi
}

sxiv_sel()
{
	if hash sxiv >/dev/null 2>&1; then
		WALL_PATH="$(sxiv -rto "$HOME/Pictures" | awk 'NR==1')"
		[[ $WALL_PATH ]] && return 0
	else
		printf "error: this requires sxiv\n"
	fi
	exit 0
}

while getopts ":hxSs:t:m:" OPT; do
	case $OPT in
		h)
			printf "usage: %s [-x <y/n>] [-S, [-s <image>]] [-m monitor] [-t set_type]\n" "${0##*/}"
			exit 0
			;;
		s)
			CHW='chwall'
			if [[ $OPTARG =~ (^.*\.jpg$|^.*\.png$) && -f $OPTARG ]]; then
				WALL_PATH="$OPTARG"
			else
				badarg
			fi
			;;
		t)
			if [[ $OPTARG =~ (^center$|^fill$|^max$|^scale$|^tile$) ]]; then
				SET_TYPE="$OPTARG"
			else
				badarg
			fi
			;;
		m)
			if [[ ${OPTARG:0:1} =~ [0-2] ]]; then
				SET_MON="${OPTARG:0:1}"
			else
				badarg
			fi
			;;
		S)
			CHW='chwall'
			GUI='sxiv_sel'
			;;
		x)
			if [[ $OPTARG =~ (y|Y) ]]; then
				NO_XINERAMA=""
			elif [[ $OPTARG =~ (n|N) ]]; then
				NO_XINERAMA='--no-xinerama'
			else
				badarg
			fi
			;;
		:)
			badarg
			;;
		\?)
			printf "Invalid option: -%s\n" "$OPTARG"
			exit 2
	esac
done

eval ${GUI}
eval ${CHW}
run
```


## 需要配合实际的壁纸设置工具一起使用的程序

- fbsetbg
```sh
fbsetbg -C -R "$HOME/wallpaper/" &
```
