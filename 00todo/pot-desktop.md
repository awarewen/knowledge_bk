- [GitHub - pot-app/pot-desktop: 🌈一个跨平台的划词翻译软件 | A cross-platform software for text translation.](https://github.com/pot-app/pot-desktopj)


# 安装
yay -S pot-translate

## Commands
````
pot cofig # Start the configuration window
pot persistent # Input translation
pot translate # Selection translation
pot screenshot_ocr # Screenshot OCR
pot screenshot_translate # Screenshot Translate
pot screenshot_ocr without_screenshot # Screenshot OCR(without screenshot)
pot screenshot_translate without_screenshot # Screenshot Translate(without screenshot)
````

## wayland (Hyprland)

````
bind = $ALT_MOD, X, exec, notify-send "Pot OCR 翻译" && grim -g "$(slurp)" ~/.cache/com.pylogmon.pot/pot_screenshot_cut.png && pot screenshot_ocr without_screenshot

bind = $ALT_MOD, C, exec, notify-send "Pot 截图翻译" && grim -g "$(slurp)" ~/.cache/com.pylogmon.pot/pot_screenshot_cut.png && pot screenshot_translate without_screenshot

bind = $ALT_MOD, V, exec, notify-send "Pot 划词翻译" && pot translate

bind = $ALT_MOD, B, exec, notify-send "Pot 剪切板翻译" && pot popclip "$(wl-paste)"

````

## The translation window follows the mouse position.

````
windowrulev2 = float, class:(pot), title:(Translator|OCR|PopClip|Screenshot Translate) # Translation window floating
windowrulev2 = move cursor 0 0, class:(pot), title:(Translator|PopClip|Screenshot Translate) # Translation window follows the mouse position.
````
