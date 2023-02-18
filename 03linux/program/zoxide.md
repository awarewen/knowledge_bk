# zoxide
- [ajeetdsouza/zoxide: A smarter cd command. Supports all major shells.](https://github.com/ajeetdsouza/zoxide)

一个更智能的cd命令，快速跳转到常用目录，支持fzf集成，对应ranger的ranger-zoxide
- [Ranger Plugin:ranger-zoxide](https://github.com/jchook/ranger-zoxide)

## install 
```markdown
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# AUR
yay -S zoxide

# 添加到shell
_ZO_FZF_OPTS
eval "$(zoxide init --cmd cd zsh)"
```
