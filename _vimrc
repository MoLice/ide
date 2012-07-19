" Vim配置文件，通过搜索#n可快速定位到目录
" Maintainer: MoLice <molice123@gmail.com>
" Last Change: Dec 28, 2011

" #1 vim属性
" #2 界面：颜色/窗口分割
" #3 排版：缩进/颜色
" #4 编辑：光标定位/搜索
" #5 快捷键映射
" #6 拓展功能


" === #1 vim属性 ===

let tlist_js_settings='javascript;s:string;a:array;o:object;f:function'
autocmd! bufwritepost _vimrc source $VIM/_vimrc
                            " 在_vimrc被更新后自动应用最新配置
set langmenu=zh_CN.UTF-8    " 设置菜单显示编码
set helplang=cn
syntax on                   " 打开语法高亮
set number                  " 显示行号
filetype plugin on          " 检测文件类型
filetype indent on
set sessionoptions-=curdir
set sessionoptions+=sesdir
set autoread                " 自动重新加载被外部更新的文件
set nobackup                " 取消自动备份
set ruler                   " 编辑时在右下角显示光标位置的状态行
set showcmd                 " 显示当前正在键入的命令
set tags=tags;              " 将tags文件添加进来
set autochdir               " 自动切换目录为当前文件所在目录
set iskeyword+=_,$,@,%,#,-  " 带有如下符号的单词不要被换行分割
set ff=unix
set encoding=utf-8        " 设置文件保存的编码
set fileencoding=utf-8    " 设置保存文件采用的编码，会改变当前已打开的文件编码
set fileencodings=utf-8,gb18030     " 设置打开文件时要猜测的编码列表


" 自定义<leader>
let mapleader=","
let g:mapleader=","

" 修复编码问题
if has("multi_byte")
    set termencoding=utf-8
    set formatoptions+=mM

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language message zh_CN.UTF-8
    endif
else
    echoerr "对不起，此版本的gVim不支持multi_byte"
endif
" 自定义状态栏
set laststatus=2
function! CurrentDir()
    let curdir = substitute(getcwd(), "", "", "g")
    return curdir
endfunction
set statusline=\ [File]\ %F%m%r%h\ %w\ \ [PWD]\ %r%{CurrentDir()}%h\ \ %=[Line]\ %l,%c\ %=\ %P

" === #2 界面：颜色/窗口分割 ===

colorscheme desert          " 配色方案（可用:highlight查看配色方案细节）
set cursorline              " 高亮显示当前行列
set cursorcolumn
set equalalways             " 分割窗口时保持平衡
let g:javascript_enable_domhtmlcss=1
                            " js语法高亮脚本的设置
set guioptions=0

" === #3 排版：缩进/颜色 ===

set linespace=4             " 行高
set nowrap                  " 禁止自动折行
set autoindent              " 自动缩进
set cindent
set shiftwidth=4            " 统一缩进为4
set tabstop=4               " Tab宽度为4
set softtabstop=4           " 使用backspace时可一次性删除4个空格
set expandtab               " 使用空格代替Tab
set listchars=tab:>-,trail:-
                            " 使用-来显示Tab
"set foldlevel=100           " 设置vim启动时不开启代码折叠
" 为不同文件设置不同缩进
if has("autocmd")
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType less setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab
endif
" 字体设置
if has("win32")
    set guifont=Courier_New:h10:cANSI
    au GUIEnter * simalt ~x
elseif has("mac") || has("macunix")
    set guifont=Monaco:h10
else
    set guifont=Monospace\ 10
endif

" === #4 编辑：光标定位/搜索 ===

set showmatch               " 高亮显示匹配括号
set matchpairs=(:),{:},[:],<:>
                            " 匹配括号的规则，增加针对html的<>
set backspace=2
" 自动补全成对括号
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
set ignorecase              " 搜索忽略大小写
set incsearch               " 即时搜索
set hlsearch                " 高亮搜索结果
set whichwrap+=<,>,h,l      " 允许backspace和光标键跨行边界

" === #5 快捷键映射 ===

" 快速打开vimrc配置文件
nmap <leader>i :e $VIM/_vimrc<CR>

" 设置快捷键保存/读取会话内容
nmap <leader>s :mksession! ~\VimTemp.vim<CR>:wviminfo! ~\VimTemp.viminfo<CR>
nmap <leader>o :source ~\VimTemp.vim<CR>:rviminfo ~\VimTemp.viminfo<CR>

" 快速打开服务器上的文件
nmap <leader>th :e \\10.6.208.17\dev\qqmail\webmail4\template\zh_cn\htmledition\exs_ftn_new.html<CR>
nmap <leader>tc :e \\10.6.208.17\dev\qqmail\webmail4\htdocs\zh_cn\htmledition\style\ft_new.css<CR>


" 模仿MS Windows中的快捷键
vmap <C-c> "+y
vmap <C-x> "yd
vmap <C-v> "+p
nmap <C-v> "+p
nmap <C-a> ggvG$

" 强行设置设置文件类型
nmap <leader>h :set ft=xhtml<CR>
nmap <leader>c :set ft=css<CR>
nmap <leader>j :set ft=javascript<CR>
nmap <leader>d :set ft=htmldjango<CR>
nmap <leader>p :set ft=php<CR>
nmap <leader>l :set ft=less<CR>

" 编辑器标签卡快捷键
nmap tt :tabnew<CR>
nmap tn :tabnext<CR>
nmap tp :tabprevious<CR>
nmap tc :tabclose<CR>

" 窗口的分割、关闭及切换
nmap ws :split<cr>
nmap wv :vsplit<cr>
nmap wc :close<cr>
" 用<A-h,j,k,l>切换到上下左右的窗口中去
nmap <A-j> <C-W>j
nmap <A-k> <C-W>k
nmap <A-h> <C-W>h
nmap <A-l> <C-W>l

" 打开TagList窗口
nmap tl :Tlist<CR>

" 打开Project窗口
nmap pr :Project<CR>
" 刷新Project
nmap <leader>r \r<CR>

" === #6 拓展功能 ===

" HTML标签补全
function! InsertHtmlTag()
    let pat = '\c<\w\+\s*\(\s\+\w\+\s*=\s*[''#$;,()."a-z0-9]\+\)*\s*>'
    normal! a>
    let save_cursor = getpos('.')
    let result = matchstr(getline(save_cursor[1]), pat)
    if (search(pat, 'b', save_cursor[1]))
        normal! lyiwf>
        normal! a</
        normal! p
        normal! a>
    endif
    :call cursor(save_cursor[1], save_cursor[2], save_cursor[3])
endfunction
inoremap > <ESC>:call InsertHtmlTag()<CR>a

" F8 将路径指向当前文件所在路径
function! Change_curr_dir()
  let _dir = expand("%:p:h")
  exec 'cd '._dir
  unlet _dir
endfunction
imap <F8> :call Change_curr_dir()

" 设置html文件的语法补全函数
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

"""""""""""""""""""""""
" TagList配置
"""""""""""""""""""""""
if has('win32')                 " 指定系统中ctags的位置
    let Tlist_Ctags_Cmd='ctags.exe'
else
    let Tlist_Ctags_Cmd='/usr/bin/ctags'
endif
let Tlist_Show_One_File=1       " 同时只显示一个文件的list
let Tlist_Exit_OnlyWindow=1     " 如果taglist是最后一个窗口则退出vim
let Tlist_Use_Right_Window=1    " 显示位置为右侧
let Tlist_GainFocus_On_ToggleOpen=1
                                " 打开taglist后自动聚焦

"""""""""""""""""""""""
" LookupFile配置
" Author: happyvim  
" Function: ProjectTagUpdateLookupFile  
" Description: regenerate lookupfile tags  
"""""""""""""""""""""""
function! ProjectTagUpdateLookupFile()  
  echo "generate lookupfile.tag"  
  if filereadable(g:project_lookup_file)  
    call delete(g:project_lookup_file)  
  endif  
  execute "cd " .  g:this_project_base_dir  
  let l:lookup_tags = ["!_TAG_FILE_SORTED   2   //2=foldcase//"]   
  
  if has("win32")  
    let l:this_project_base_dir = substitute(g:this_project_base_dir, "/", "//", "g") . "//"  
  else  
    let l:this_project_base_dir = g:this_project_base_dir  
  endif  
  "let l:lookup_tags_file_string = system(g:project_find_program . " " . l:this_project_base_dir . " " . g:project_find_param)  
  let l:lookup_tags_file_string = system(g:project_find_program . " " . g:project_find_param)  
  let l:lookup_tags_file_list = split(l:lookup_tags_file_string, '/n')  
  let l:lookup_tags_file_list = sort(l:lookup_tags_file_list)  
  
  let l:item = ""  
  let l:count = 0   
  for l:item in l:lookup_tags_file_list  
    let l:item = fnamemodify(l:item, ':t') . "/t" . l:item . "/t" . "1"  
    let l:lookup_tags_file_list[l:count] = l:item  
    let l:count = l:count + 1  
  endfor   
  call extend(l:lookup_tags, l:lookup_tags_file_list)  
  call writefile(l:lookup_tags, g:project_lookup_file)  
  echo "generate lookupfile tag done"  
endfunction  
  
"dir /B /S /A-D /ON *.fnc *.prc *.trg *.pck *.typ *.spc *.bdy *.tps *.tpb *.txt *.sql > filenametags  
"dir /B /S /A-D /ON | findstr /V ".class$ .xls$ .doc$ .ppt$ .pdf$ .jpg$ .gif$ .zip$ .rar$ .jar$ .dat$ .mdb$ .dmp$ " > filenametags  
let g:project_lookup_file = "D:/APMServ5.2.6/www/htdocs/filenametags"  
let g:project_find_program = "dir /B /S /A-D /ON"  
let g:project_find_param = "*.fnc *.prc *.trg *.pck *.typ *.spc *.bdy *.tps *.tpb *.txt *.sql"  
let g:this_project_base_dir = "D:/APMServ5.2.6/www/htdocs"  
  
let g:LookupFile_TagExpr = '"D:/APMServ5.2.6/www/htdocs/filenametags"'

"""""""""""""""""""""""
" snippet配置
"""""""""""""""""""""""
let g:snippets_dir='$VIMRUNTIME/snippets'
let g:snips_author="MoLice"
ino <c-j> <c-r>=TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=TriggerSnippet()<cr>
