" Vim syntax file
" Language:     QMail Template
" Version:      1.0
" Maintainer:   MoLice <molicechen@tencent.com>
" Last Change:  2012-09-04
" Remark:       基于html语法高亮的基础，增加模板语言高亮。
" 缺少完整的模板语法检查，只供高亮阅读的便利。
" 1. 在vimrc配置文件里添加文件类型检测
" autocmd! BufRead *.html call IsQmt()
" function! IsQmt()
"   let s:n = 1
"   let s:lines = line("$")
"   while s:n <= s:lines
"     if getline(s:n) =~ "<%"
"       setf qmt
"       return
"     endif
"     let s:n = s:n + 1
"   endwhile
" endfunction
"
" 2. 添加设定文件类型的键映射
" nmap <leader>t :set ft=qmt<CR>
"
" 3. 使用qmt.snippets提供缩写/展开支持

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" 加载xhtml高亮语法
runtime! syntax/xhtml.vim

" 以下的规则，大小写敏感
syntax case match

" 基本模板标签
syntax region qmtTagBlock start=/<%/ end=/%>/ contains=qmtStatement,qmtFuncName,qmtVariable oneline
syntax region qmtFuncTagBlock start=/<%@/ end=/%>/ contains=qmtFuncArgument,qmtVariable,qmtStatement,qmtNumber oneline
" 注释
syntax region qmtComment start=/<%##/ end=/##%>/ contains=qmtTodo
" 关键字
syntax keyword qmtStatement if else elseif endif for endfor contained
" 左右临近@/%这些字符，会被看成一个单词，所以需要再次匹配
syntax match qmtStatement /@\(if\|else\|elseif\|endif\|for\|endfor\)\s*%\=/ms=s+1,me=e-1 contained
" 数字
syntax match qmtNumber /\d/ contained
" 模板TODO
syntax keyword qmtTodo TODO FIXME XXX contained
" 模板变量
syntax match qmtVariable /\$[a-zA-Z0-9][a-zA-Z0-9_]*\$/ contains=qmtGlobalVar contained
" 模板函数
syntax region qmtFuncArgument matchgroup=qmtFuncName start=/[a-zA-Z0-9_]\+(/ end=/)/ contains=qmtVariable,qmtStatement contained
" 全局变量
syntax match qmtGlobalVar /DATA\|uid\|username/ contained

" TODO 增加更多错误检测
" 模板标签错误
syntax match qmtTagError /%>\|<[^%].*%>/

if version >= 508 || !exists("did_django_syn_inits")
  if version < 508
    let did_django_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink qmtTagBlock PreProc
  HiLink qmtFuncTagBlock PreProc

  HiLink qmtVariable Identifier
  HiLink qmtFuncName Function

  HiLink qmtStatement Statement

  HiLink qmtGlobalVar Special

  HiLink qmtNumber Number

  HiLink qmtComment Comment
  HiLink qmtTagError Error
  HiLink qmtTodo Todo

  delcommand HiLink
endif

let b:current_syntax = "qmt"
