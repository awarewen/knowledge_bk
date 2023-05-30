# tmux
- [tmux/tmux: tmux source code](https://github.com/tmux/tmux)
- [rothgar/awesome-tmux: A list of awesome resources for tmux](https://github.com/rothgar/awesome-tmux)

## install
```markdown
yay -S tmux
```

## custom config
- [gpakosz/.tmux: 🇫🇷 Oh my tmux! My self-contained, pretty & versatile tmux configuration made with ❤️](https://github.com/gpakosz/.tmux)
```markdown
$ cd
$ git clone https://github.com/gpakosz/.tmux.git
$ ln -s -f .tmux/.tmux.conf
$ cp .tmux/.tmux.conf.local .
```
- [rothgar/awesome-tmux: A list of awesome resources for tmux](https://github.com/Determinant/tmux-colortag)

## plugins
```
~/.tmux.conf.local
__________________
# to enable a plugin, use the 'set -g @plugin' syntax:
# visit https://github.com/tmux-plugins for available plugins
#set -g @plugin 'tmux-plugins/tmux-copycat'
        set -g @plugin 'CrispyConductor/tmux-copy-toolkit'
        set -g @plugin 'tmux-plugins/tmux-yank'
        set -g @plugin 'tmux-plugins/tmux-open'
#set -g @plugin 'tmux-plugins/tmux-cpu'
#set -g @plugin 'tmux-plugins/tmux-resurrect'
#set -g @plugin 'tmux-plugins/tmux-continuum'
#set -g @continuum-restore 'on'
#++
        set -g @plugin 'jimeh/tmux-themepack' # custom theme
#++
#set -g @plugin 'schasse/tmux-jump'#+j
#++
#++
```

```
~/.tmux.conf
____________
# -- plugin 'jimeh/tmux-themepack' # custom theme
#set -g @themepack 'basic'（默认）
#set -g @themepack 'powerline/block/blue'
#set -g @themepack 'powerline/block/cyan'
#set -g @themepack 'powerline/default/green'
        set -g @themepack 'powerline/double/magenta'
```



### ~/.tmux.conf.local
```
set -g @plugin 'CrispyConductor/tmux-copy-toolkit'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-open'

set -g @plugin 'jimeh/tmux-themepack' # theme

```
