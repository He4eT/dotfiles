# Screensots

[imgur album](https://imgur.com/a/VM9QJel)

# Bootstrap

1. `git clone https://github.com/He4eT/dotfiles.git ~/.dotfiles`
1. Add [ppa:kgilmer/speed-ricer](https://launchpad.net/~kgilmer/+archive/ubuntu/speed-ricer) to your system's Software Sources
1. Run `./installPackages.sh`
1. Run `./apply.sh`
1. Export gtk-theme and icons with `oomox` and apply them with `lxappearance`
1. Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)

# Firefox

1. Set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true` with `about:config`
1. Locate profile with `about:profiles`
1. Copy `firefox/userChome.css` to `{profile}/chrome/userChrome.css`
1. Customize interface

# etc

1. Add `PATH="$HOME/apps/bin:$PATH"` to `~/.profile`
1. Fix ugly Telegram FileChooser with adding `QT_QPA_PLATFORMTHEME=gtk3` to `/etc/environment`
1. Or `XDG_CURRENT_DESKTOP=gnome`
1. Replace ugly ● with awesome ▴ in `~/.oh-my-zsh/themes/minimal.zsh-theme`
1. Create ~/.config/gtk-3.0/gtk.css: `* { outline-width: 0px; }`
