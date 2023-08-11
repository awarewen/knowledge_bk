- [iio-hyprland for GPD p3](git@github.com:awarewen/iio-hyprland-GPD-p3.git)

- 增加了一个 `system_fmt`函数，将触控和触控笔分开来控制
````
    // only transform touch devices
    // (and pray that our lord and savior vaxry won't change hyprctl output)
    system_fmt("while IFS=$'\n' read -r device ; do "
            "hyprctl keyword device:\"$device\":transform %d; "
            "done <<< \"$(hyprctl devices | awk '/Touch Device at/ {getline;print $1}')\"",
            orientation);

    // just only transform stylus for GPD POCKET 3 stylus
    if (orientation > 3) stylus_orientation += 2;
    else stylus_orientation =0;
    system_fmt("while IFS=$'\n' read -r device ; do "
            "hyprctl keyword device:\"$device\":transform %d; "
            "done <<< \"$(hyprctl devices | awk '/Tablet at|stylus/ {getline;print $1}')\"",
            stylus_orientation);
````

