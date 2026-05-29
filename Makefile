install_base:
	sudo dnf install -y \
		NetworkManager-tui \
		btop \
		cava \
		cbonsai \
		cloc \
		cmatrix \
		fastfetch \
		git \
		git-lfs \
		htop \
		httpie \
		light \
		lynx \
		mc \
		ncdu \
		neovim \
		profanity \
		pwgen \
		ranger \
		ripgrep \
		sen \
		stow \
		telnet \
		vim \
		zsh

install_gui:
	sudo dnf install -y \
		dino \
		epiphany \
		firefox \
		gimp \
		gparted \
		inkscape \
		kitty \
		mediawriter \
		qt5ct \
		telegram-desktop \
		thunderbird \
		vlc \
		fontawesome-fonts \
		terminus-fonts \
		unifont-fonts

install_multimedia:
	sudo dnf group install Multimedia

install_i3: install_base install_gui
	sudo dnf install -y \
		arandr \
		dunst \
		gpick \
		i3 \
		lxappearance \
		picom \
		polybar \
		rofi \
		rxvt-unicode \
		unclutter-xfixes \
		xclip \
		xdotool \
		xdpyinfo \
		xev \
		xkb-switch \
		xkill \
		xprop

apply_configs:
	stow -Rvt ~ home

desktop_i3: install_i3 apply_configs

# vim: set ts=4 sw=4 autoindent noexpandtab:
