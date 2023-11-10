""" Common

  set encoding=utf-8
  set nocompatible
  set mouse=a
  set scrolloff=0

  set number
  set fillchars=eob:\  " No more ~

  set nowrap
  set autoindent
  set expandtab
  set smarttab
  set tabstop=2
  set shiftwidth=2

  let mapleader = ' '
  set ttimeoutlen=10

  nnoremap <SPACE> <Nop>

  nnoremap <Esc> :nohl<CR>

  filetype plugin indent on

""" Plugins
  " :PlugInstall
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  call plug#begin('~/.vim/bundle')

    """ Themes
    Plug 'tribela/vim-transparent'
    Plug 'widatama/vim-phoenix'

    Plug 'Lokaltog/vim-monotone'
    Plug 'alexanderheldt/monokrom.vim'
    Plug 'pgdouyon/vim-yin-yang'

    """ Navigation
    Plug 'justinmk/vim-sneak'
  call plug#end()

""" Sneak

  let g:sneak#label = 1
  autocmd ColorScheme * hi Sneak guifg=black guibg=white ctermfg=black ctermbg=white
  autocmd ColorScheme * hi SneakScope guifg=black guibg=white ctermfg=black ctermbg=white
  autocmd ColorScheme * hi SneakLabel guifg=black guibg=white ctermfg=black ctermbg=white

""" Appearance

  colorscheme phoenix
  PhoenixOrange

  " Cursor
  let &t_SI.="\e[5 q"
  let &t_SR.="\e[3 q"
  let &t_EI.="\e[2 q"


""" Statusline

  hi StatusLine ctermbg=none ctermfg=white cterm=bold

  set noshowmode
  set laststatus=2

  set statusline=
  set statusline+=%#StatusLine#
  set statusline+=%{mode()}
  set statusline+=\ " Space

  set statusline+=%#LineNr#
  set statusline+=%y

  set statusline+=%#StatusLine#
  set statusline+=\ %f
  set statusline+=\ %m

  set statusline+=%=

  set statusline+=%#LineNr#
  set statusline+=%{&fileformat}
  set statusline+=\ %{&fileencoding?&fileencoding:&encoding}

  set statusline+=%#StatusLine#
  set statusline+=\ %l:%c
  set statusline+=\ %p%%


""" Copy'n'paste

  nnoremap <silent><leader>y :call system('xclip -i -selection clipboard', @@)<cr>
  vnoremap <silent><leader>y y:call system('xclip -i -selection clipboard', @@)<cr>
