set nocompatible

set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'rust-lang/rust.vim'
Plugin 'valloric/youcompleteme'
Plugin 'tell-k/vim-autopep8'
Plugin 'vim-syntastic/syntastic'
call vundle#end()

set encoding=utf-8
set list listchars=tab:→\ ,eol:↲,nbsp:␣,space:·,trail:•,extends:⟩,precedes:⟨
set list

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

:filetype indent plugin on
syntax on
hi Comment ctermfg=darkgreen
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set showcmd
set cursorline
hi CursorLine cterm=NONE ctermbg=darkgray
set showmatch
set hlsearch
set autoindent
set smartindent


noremap e $
noremap q ^

xmap aa :EasyAlign 2/\w\+/dal <CR><bar> gv <bar> :EasyAlign */\[/rm0 <CR><bar> gv <bar> :EasyAlign -/\w\+/dalrm0 <CR>

xmap acp :EasyAlign /)/rm0lm0 <CR>
xmap aop :EasyAlign /(/rm0 <CR>
xmap ac :EasyAlign /,/lm0 <CR>
xmap alw :EasyAlign -/\w\+[,\?;\?]\?/dalrm0 <CR>

set backupdir=~/.vim_backups//
set directory=~/.vim_backups//
set undodir=~/.vim_backups//

" ycm
let g:rustfmt_autosave = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
set pythonthreedll=python37.dll
set completeopt-=preview

" Autopep8
let g:autopep8_disable_show_diff=1
silent autocmd BufWritePost *.py Autopep8

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
