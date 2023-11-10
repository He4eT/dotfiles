# Common settings

export PATH=$HOME/apps/bin:$PATH
export EDITOR="/usr/bin/vim"
# export SSH_KEY_PATH="~/.ssh/rsa_id"
# export ARCHFLAGS="-arch x86_64"

# NVM

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Tuning for urxvt

xset -b
clear

# ZSH settings

export ZSH="/home/odd/.oh-my-zsh"
ZSH_CUSTOM="/home/odd/dotfiles/zsh"

ZSH_THEME="custom-minimal"
MODE_INDICATOR="%F{yellow}█%f"
VI_MODE_CURSOR_INSERT=2

CASE_SENSITIVE="false"

plugins=(
  git
  vi-mode
  fancy-ctrl-z
  fzf
)

source $ZSH/oh-my-zsh.sh

# Aliases

alias :q='exit'
alias fakemsg='echo "$(curl -s https://whatthecommit.com/index.txt)"'
alias ncdu='ncdu --color off'

## git

alias ga.='ga . && gst'
alias gcmsgrnd='git commit -m "$(fakemsg)"'

## Servers

alias here-http='hostname -I && python3 -m http.server'
alias here-http-cors='npx http-server -p 8080 --cors'
alias here-https='PORT=8080 npx https-localhost'

## Ollama

alias summon='clear && docker exec -it ollama ollama run'
alias summonable='docker exec -it ollama ollama list'

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
