# dotfiles

## Bootstrap

1. `git clone https://github.com/He4eT/dotfiles.git ~/dotfiles`
1. Run `./installPackages.sh`
1. Run `./apply.sh`
1. Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
1. Export gtk-theme and icons with `oomox` and apply them with `lxappearance`
1. [Apply](https://wiki.archlinux.org/title/Cursor_themes) the [Quintom cursor theme](https://gitlab.com/Burning_Cube/quintom-cursor-theme/-/tree/master/) as `Quintom_Snow`

## git

1. `git config --global core.pager 'less -S'`
1. `git config --global pull.rebase true`
1. `git config user.email 'email'`
1. `git config user.name 'name'`

## Telegram

1. Tinted theme: `#707070`
1. Fix ugly FileChooser with adding `QT_QPA_PLATFORMTHEME=gtk3` or `XDG_CURRENT_DESKTOP=gnome` to `/etc/environment`
