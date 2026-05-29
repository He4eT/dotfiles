# dotfiles

## Bootstrap

1. Setup SSH keys
1. `sudo dnf install git`
1. `git clone --recurse-submodules git@github.com:He4eT/dotfiles.git ~/dotfiles`
1. Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
1. `make desktop_i3`

## GTK

1. Apply [Desolate-GTK](https://github.com/He4eT/Desolate-GTK)
1. [Apply](https://wiki.archlinux.org/title/Cursor_themes) the [Quintom cursor theme](https://gitlab.com/Burning_Cube/quintom-cursor-theme/-/tree/master/) as `Quintom_Snow`
1. Add variables to `/etc/environment`:
    ```
    QT_QPA_PLATFORMTHEME=qt5ct
    XDG_CURRENT_DESKTOP=gnome
    ```

## Telegram

1. Tinted theme: `#707070`
