ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}▴%{$fg[white]%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="]%{$reset_color%} "

function braille_prompt() {
  local input="${1:-0}"
  local hash=$( echo "$input" | md5sum | cut -d' ' -f1)
  local braille=$(echo $hash | xxd -r -p | od -An -vtu1 | \
    awk '{for(i=1;i<=NF;i++) printf "\\U%08x", 0x2800 + $i}' | xargs -0 printf "%b")

  local color='\033[1;30m'
  local reset='\033[0m'
  local prefix='▣─□□□─────────────────╼⢸'
  local postfix='⡇╾──────────╼━━━━        ▒ '
  local datetime=$(date '+%Y-%m-%d %H:%M:%S')
  echo -e "${color}${prefix}${braille}${postfix}${datetime}${reset}"
}

vcs_status() {
  git_prompt_info
}

precmd() {
  local exit_code=$?
  braille_prompt "$exit_code"
  if [ $exit_code -ne 0 ]; then
    echo "├╼ Exit code: $exit_code"
  fi
}

PROMPT='└╼ %2~ $(vcs_status)»%b '
