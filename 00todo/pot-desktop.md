- [GitHub - pot-app/pot-desktop: 🌈一个跨平台的划词翻译软件 | A cross-platform software for text translation.](https://github.com/pot-app/pot-desktopj)


# install 
yay -S pot-translate

## wayland Screenshot

````
bind = ALT, X, exec, grim -g "$(slurp)" ~/.cache/com.pylogmon.pot/pot_screenshot_cut.png && pot screenshot_ocr without_screenshot
bind = ALT, C, exec, grim -g "$(slurp)" ~/.cache/com.pylogmon.pot/pot_screenshot_cut.png && pot screenshot_translate without_screenshot
````

## The translation window follows the mouse position.

````
windowrulev2 = float, class:(pot), title:(Translator|OCR|PopClip|Screenshot Translate) # Translation window floating
windowrulev2 = move cursor 0 0, class:(pot), title:(Translator|PopClip|Screenshot Translate) # Translation window follows the mouse position.
````


## API 
- 百度


