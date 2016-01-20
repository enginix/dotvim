"" begin of vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'taglist.vim'
Bundle 'winmanager'
Bundle 'bufexplorer.zip'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'altercation/vim-colors-solarized'
Bundle 'a.vim'
Bundle 'Maxlufs/c.vim'
Bundle 'Visual-Mark'
"" ascii art
Bundle 'DrawIt'
"UltiSnips
Bundle 'UltiSnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'rdnetto/YCM-Generator'
Bundle 'leafo/moonscript-vim'
Plugin 'aceofall/gtags.vim'
"" end of vundle

set background=dark
"colorscheme solarized

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

function! Get_session_name()
    let name = substitute(getcwd(), "/", "_", "g")
    return name
endfunction

" get tags dir
function! Get_tag_dir()
    let cdir = substitute(getcwd(), "/src/.*", "", "")
    "let cdir = substitute(cdir, cdir, "&/", "")
    return cdir
endfunction

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

let mapleader = ';'
syntax enable
syntax on

set nu
colorscheme desert

"" indent guides
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
nmap <silent> <Leader>i <Plug>IndentGuidesToggle
"" indent guides
"" ulti snips
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"
"" ulti snips

"" YCM 
" 补全菜单配色
" 菜单
"highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
let g:syntastic_c_checkers = ['YouCompleteMe']
let g:syntastic_c_check_header = 1
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings=1
" 引入 C++ 标准库 tags
set tags+=/home/enginix/.vim/sys.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全            
let g:ycm_seed_identifiers_with_syntax=1
"" ycm

" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>bl :MBEToggle<cr>
" buffer 切换快捷键
map <C-Tab> :MBEbn<cr>
map <C-S-Tab> :MBEbp<cr>

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>
nmap tm :FirstExplorerWindow<cr>
nmap bm :BottomExplorerWindow<cr>
set cscopequickfix=s-,c-,d-,i-,t-,e-
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <F6> :cn<cr>
nmap <F7> :cp<cr>

"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1

nnoremap <silent> <F12> :A<CR>
nnoremap <silent> <F8> :Grep<CR>
filetype plugin indent on
set completeopt=longest,menu

set foldmethod=syntax
" 启动 vim 时不要自动折叠代码
set nofoldenable

"处理乱码
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set fileformats=unix
"set encoding=prc
"set expandtab "使用space代替tab.
set tabstop=4  "四个空格。
set shiftwidth=4 "自动缩进的宽度
"for a.vim plug
"search in regex path specified
let g:alternateSearchPath = 'reg:|src/\([^/]\)|src/include/\1|,reg:|src/include/\([^/]\)|src/\1|'
"add ../include/* to gf search path
set path+=../include/*

"set sessionoptions
"set sessionoptions-=curdir
"set sessionoptions+=sesdir

"" 这个机制现在存在一些问题，先注释掉。 7Sep2013 YJ
"let currdir=getcwd()
""save work status before quit
"let session_name = Get_session_name()
"exe "source ~/.vim/bak/".session_name.".vim"
"exe "rviminfo ~/.vim/bak/".session_name.".viminfo"
"exe "au VimLeavePre * mksession! ~/.vim/bak/".session_name.".vim"
"exe "au VimLeavePre * wviminfo ~/.vim/bak/".session_name.".viminfo"
"exe "au VimEnter * !rm -v ~/.vim/bak/".session_name.".vim*"
"exe "cd ".currdir

set cscopetag
set cscopeprg=gtags-cscope
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1
au VimEnter * call VimEnterCallback()
au BufAdd *.[ch] call FindGtags(expand('<afile>'))
au BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))

function! FindFiles(pat, ...)
    let path = ''
    for str in a:000
        let path .= str . ','
    endfor

    if path == ''
        let path = &path
    endif

    echo 'finding...'
    redraw
    call append(line('$'), split(globpath(path, a:pat), '\n'))
    echo 'finding...done!'
    redraw
endfunc

function! VimEnterCallback()
    for f in argv()
        if fnamemodify(f, ':e') != 'c' && fnamemodify(f, ':e') != 'h'
            continue
        endif

        call FindGtags(f)
    endfor
endfunc

function! FindGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    while 1
        let tmp = dir . '/GTAGS'
        if filereadable(tmp)
            exe 'cs add ' . tmp . ' ' . dir
            break
        elseif dir == '/'
            break
        endif

        let dir = fnamemodify(dir, ":h")
    endwhile
endfunc

function! UpdateGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    exe 'silent !cd ' . dir . ' && global -u &> /dev/null &'
endfunction

function! SubstituteWordInLine(word)
    let line=getline(".")
    let target = '<%:' . word . '%>'
    let replace = substitute(line, word, target)
    setline(".", replace)
endfunction
nmap <leader>s :s/\(<c-r>=expand("<cword>")<cr>\)/<%:\1%><cr> 
