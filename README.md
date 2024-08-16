# dotfiles

## Bootstrap

1. `git clone https://github.com/He4eT/dotfiles.git ~/dotfiles`
1. Run `./installPackages.sh`
1. Run `./apply.sh`
1. Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)

## GTK

1. Apply [Desolate-GTK](https://github.com/He4eT/Desolate-GTK)
1. [Apply](https://wiki.archlinux.org/title/Cursor_themes) the [Quintom cursor theme](https://gitlab.com/Burning_Cube/quintom-cursor-theme/-/tree/master/) as `Quintom_Snow`
1. Add variables to `/etc/environment`:
    ```
    QT_QPA_PLATFORMTHEME=qt5ct
    XDG_CURRENT_DESKTOP=gnome
    ```

## git

1. `git config --global core.pager 'less -S'`
1. `git config --global pull.rebase true`
1. `git config user.email 'email'`
1. `git config user.name 'name'`

## Telegram

1. Tinted theme: `#707070`
