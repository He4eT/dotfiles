# .Xresources
rm ~/.Xresources
ln -sv ~/dotfiles/root/.Xresources ~/.Xresources

# .zshrc
rm ~/.zshrc
ln -sv ~/dotfiles/root/.zshrc ~/.zshrc

# .vimrc
rm ~/.vimrc
ln -sv ~/dotfiles/root/.vimrc ~/.vimrc

# kitty
mkdir -p ~/.config/kitty
rm ~/.config/kitty/kitty.conf
ln -sv ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf

# neovim
mkdir -p ~/.config/nvim
rm ~/.config/nvim/init.lua
ln -sv ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua

# i3
mkdir -p ~/.config/i3
rm ~/.config/i3/config
ln -sv ~/dotfiles/i3/config ~/.config/i3/config
sudo cp ~/dotfiles/i3/i3-gaps.desktop /usr/share/xsessions/i3-gaps.desktop

# polybar
mkdir -p ~/.config/polybar
rm ~/.config/polybar/config
ln -sv ~/dotfiles/polybar/config ~/.config/polybar/config

# rofi
mkdir -p ~/.config/rofi
rm ~/.config/rofi/config
ln -sv ~/dotfiles/rofi/config.rasi ~/.config/rofi/config.rasi
rm ~/.config/rofi/paper-float.rasi
ln -sv ~/dotfiles/rofi/paper-float.rasi ~/.config/rofi/paper-float.rasi

# oomox
mkdir -p ~/.config/oomox/colors
rm ~/.config/oomox/colors/gray
ln -sv ~/dotfiles/oomox/colors/gray ~/.config/oomox/colors/gray

# notifications
mkdir -p ~/.themes/notifications/xfce-notify-4.0
rm ~/.themes/notifications/xfce-notify-4.0/gtk.css
ln -sv ~/dotfiles/notifications/notifications.css ~/.themes/notifications/xfce-notify-4.0/gtk.css
