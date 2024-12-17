xset -b
clear

# Common settings

export PATH=$HOME/apps/bin:$PATH

if [[ "$NVIM" ]]; then
  export EDITOR="/usr/bin/nvim"
else
  export EDITOR="/usr/bin/vim"
fi

# NVM

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ZSH settings

export ZSH="/home/odd/.oh-my-zsh"
ZSH_CUSTOM="/home/odd/dotfiles/zsh"

# https://github.com/ohmyzsh/ohmyzsh/issues/12328#issuecomment-2043492331
zstyle ':omz:alpha:lib:git' async-prompt no

ZSH_THEME="custom-minimal"
MODE_INDICATOR="%F{yellow}◼%f"
VI_MODE_CURSOR_INSERT=2
KEYTIMEOUT=1
bindkey -M vicmd 'V' edit-command-line

CASE_SENSITIVE="false"

plugins=(
  git
  vi-mode
  fancy-ctrl-z
  fzf
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Aliases

alias :q='exit'
alias fakemsg='echo "$(curl -s https://whatthecommit.com/index.txt)"'
alias ncdu='ncdu --color off'
alias lynx='WWW_HOME=https://duckduckgo.com \
  lynx -accept_all_cookies -nocolor -nopause -show_cursor:true -tna -vikeys'
alias st='fastfetch -c ~/dotfiles/fastfetch/st.jsonc'
alias status='clear && fastfetch -c ~/dotfiles/fastfetch/status.jsonc'

# Aliases for nmtui @see https://lemmy.world/post/17689127

NMTUI_COLORS='
  root=black,default;
  actlistbox=black,lightgray;
  actsellistbox=black,yellow;
'
alias nmtui='NEWT_COLORS="$NMTUI_COLORS" nmtui'
alias nmtui-connect='NEWT_COLORS="$NMTUI_COLORS" nmtui-connect'

## git

alias cdg='cd $(git rev-parse --show-toplevel 2>/dev/null)'
alias ga.='ga . && gst'
alias gcmsgrnd='git commit -m "$(fakemsg)"'
alias ghist="git log --name-only --pretty='' | sed -e '/^\\s*$/d' | awk '!seen[\$0]++' | less"
alias cdgr='cd $(git rev-parse --show-toplevel)'

## Servers

alias here-http='hostname -I && python3 -m http.server'
alias here-http-cors='npx http-server -p 8080 --cors'
alias here-https='PORT=8080 npx https-localhost'

## Ollama

alias summon='clear && docker exec -it ollama ollama run'
alias summonable='docker exec -it ollama ollama list'

## Music
alias somafm='npx ~/trash/fuzzsoma'

## Copy from terminal
# See .XResources

alias last-terminal-screenshot='\
  vim \
  -c "norm G" \
  -c "set relativenumber" \
  /tmp/urxvt-screen-content.txt
'
alias yank='\
  xdotool keydown shift keydown Print ;\
  xdotool keyup Print keyup shift ;\
  last-terminal-screenshot ;\
'
