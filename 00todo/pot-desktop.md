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

## tesseract 配合 pot-desktop 实现 ocr 识别并翻译
pot 有一个 'tesseract.js' 但是识别的效果和速度都不理想，而 arch linux 中可以安装本地的 tesseract 识别引擎，搭配对应语言的数据文件识别精度速度都成倍提升。
````
tesseract-data-chi_sim 中文简体
tesseract-data-eng     英语
````

