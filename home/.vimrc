""" Plugins
  " :PlugInstall
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  call plug#begin('~/.vim/bundle')
    Plug 'tribela/vim-transparent'
    Plug 'widatama/vim-phoenix'
  call plug#end()
 
""" Common

  set mouse=a
  set nowrap
  set autoindent
  set expandtab
  set tabstop=2
  set shiftwidth=2

  filetype plugin indent on

  let mapleader = ' '
  nnoremap <SPACE> <Nop>
  nnoremap <silent> <Esc> :nohlsearch<CR>

""" Appearance

  set number
  set fillchars=eob:\ "

  colorscheme phoenix
  PhoenixOrange

  " Cursor
  let &t_SI.="\e[5 q"
  let &t_SR.="\e[3 q"
  let &t_EI.="\e[2 q"


""" Statusline

  set noshowmode
  set laststatus=2

  hi StatusLine ctermbg=none ctermfg=white cterm=bold
  hi StatusLineDim ctermbg=none ctermfg=gray cterm=bold

  set statusline=
  set statusline+=%#StatusLine#
  set statusline+=[%{mode()}]
  set statusline+=\ %f
  set statusline+=\ %m

  set statusline+=%=

  set statusline+=%#StatusLineDim#
  set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
  set statusline+=\ %{&fileformat}
  set statusline+=\ %y

  set statusline+=%#StatusLine#
  set statusline+=\ %p%%
  set statusline+=\ %l:%c

""" Copy'n'paste

  function! PushToClipboard()
    if !empty($WAYLAND_DISPLAY)
      call system('wl-copy', @")
    else
      call system('xclip -i -selection clipboard', @")
    endif
  endfunction

  nnoremap <silent><leader>y :call PushToClipboard()<CR>
  vnoremap <silent><leader>y y:call PushToClipboard()<CR>
