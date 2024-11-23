sudo dnf install \
  fontawesome-fonts \
  terminus-fonts \
  unifont-fonts \
  i3 \
  picom \
  polybar \
  rofi \
  lxappearance \
  gparted \
  gimp \
  vlc \
  qt5ct \
  rxvt-unicode \
  cbonsai \
  cmatrix \
  fastfetch \
  NetworkManager-tui \
  arandr \
  gpick \
  light \
  btop \
  htop \
  ncdu \
  lynx \
  sen \
  vim \
  neovim \
  ripgrep \
  xclip \
  xdotool \
  xdpyinfo \
  git \
  zsh \
  mc \
  ranger \
  telegram-desktop \

sudo dnf group install Multimedia

mkdir ./zsh/plugins
git clone git@github.com:zsh-users/zsh-autosuggestions.git ~/dotfiles/zsh/plugins/zsh-autosuggestions
