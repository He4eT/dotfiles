# .Xresources
ln -sv ~/dotfiles/root/.Xresources ~/.Xresources

# .Xresources
rm ~/.zshrc
ln -sv ~/dotfiles/root/.zshrc ~/.zshrc

# i3
mkdir -p ~/.config/i3
ln -sv ~/dotfiles/i3/config ~/.config/i3/config

# polybar
mkdir -p ~/.config/polybar
ln -sv ~/dotfiles/polybar/config ~/.config/polybar/config

# rofi
mkdir -p ~/.config/rofi
ln -sv ~/dotfiles/rofi/config ~/.config/rofi/config
ln -sv ~/dotfiles/rofi/paper-float.rasi ~/.config/rofi/paper-float.rasi

# oomox
mkdir -p ~/.config/oomox/colors
ln -sv ~/dotfiles/oomox/colors/gray ~/.config/oomox/colors/gray

# notifications
mkdir -p ~/.themes/notifications/xfce-notify-4.0
ln -sv ~/dotfiles/notifications/notifications.css ~/.themes/notifications/xfce-notify-4.0/gtk.css
