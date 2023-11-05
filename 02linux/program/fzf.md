# fzf
- [junegunn/fzf: A command-line fuzzy finder](https://github.com/junegunn/fzf)

install: `sudo pacman -S fzf`

## configuretion
```markdown

- zoxide fzf OPT
export _ZO_FZF_OPTS='--height 60% --layout=reverse-list --border --preview "echo {} | ~/.config/fzf/fzf_preview.py" --preview-window=right -m'

- fzf OPT
export FZF_DEFAULT_COMMAND='fd --hidden --follow . /home/awarewen /etc /usr' #. /etc /home
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse-list --border --preview "echo {} | ~/.config/fzf/fzf_preview.py" --preview-window=right -m'

```

## fzf_preview
- 添加文件预览 使用 `bat`
```markdown
.config/fzf/fzf_preview
_______________________
#! /usr/bin/python3

import os
import sys


def fzf_preview(rg_name):
    rg_list = rg_name.split(':')
    if len(rg_list) == 1:
        bat_range = 0
    else:
        bat_range = rg_list[1].replace('\n', '')
    file_path_list = rg_list[0].replace('\n', '').split('/')
    for i,filep in zip(range(len(file_path_list)), file_path_list):
        path_space = filep.find(' ')
        if not path_space == -1:
            file_path_list[i] = "'{}'".format(filep)
        file_path = '/'.join(file_path_list)
    preview_nameandline = [file_path, bat_range]
    return preview_nameandline


if __name__ == "__main__":
    rg_name = sys.stdin.readlines()[0]
    preview_nameandline = fzf_preview(rg_name)
    if os.path.isdir(preview_nameandline[0]):
        os.system('ls -la {}'.format(preview_nameandline[0]))
    elif preview_nameandline[0].replace("'", '').endswith(('.zip', '.ZIP')):
        os.system('unzip -l {}'.format(preview_nameandline[0]))
    elif preview_nameandline[0].replace("'", '').endswith(('.rar', '.RAR')):
        os.system('unrar l {}'.format(preview_nameandline[0]))
    elif preview_nameandline[0].replace("'", '').endswith('.torrent'):
        os.system('transmission-show {}'.format(preview_nameandline[0]))
    elif preview_nameandline[0].replace("'", '').endswith(('.html', '.htm', '.xhtml')):
        os.system('w3m -dump {}'.format(preview_nameandline[0]))
    else:
        os.system('bat --style=numbers --color=always -r {}: {}'.format(
            preview_nameandline[1], preview_nameandline[0]))
```

## 相关的应用

- neovim 配置选择器 `add to .zshrc`
```
function nvims() {
  items=(
    "knvim"
    "lnvim"
    #"SpaceVim"
  )
  NVIM_CONFIG=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $NVIM_CONFIG ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $NVIM_CONFIG == "default" ]]; then
    NVIM_CONFIG=""
  fi
  NVIM_APPNAME=$NVIM_CONFIG nvim $@
}

```
