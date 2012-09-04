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
syntax region qmtNodeName matchgroup=qmtTagNode start=/<%/ skip=/[^a-zA-Z0-9]/ end=/%>/ oneline
syntax region qmtSection matchgroup=qmtTagSec start="<%#[/]\=" end="%>" oneline
syntax region qmtFuncTagBlock matchgroup=qmtTagFunc start=/<%@/ end=/%>/ contains=qmtFuncArgument,qmtStatement oneline
" 模板函数，TODO start里匹配到的statement高亮错误
syntax region qmtFuncArgument matchgroup=qmtFuncName start=/[a-zA-Z0-9_]\+(/ end=/)/ contains=qmtVariable,qmtFuncArgument,qmtNumber contained keepend oneline
" 关键字
syntax keyword qmtStatement if else elseif endif for endfor contained
" 临近%会被看成一个单词，所以需要再次匹配
syntax match qmtStatement /\(if\|else\|elseif\|endif\|for\|endfor\)[(%]/me=e-1 contained
" 数字
syntax match qmtNumber /\<\d\>/ contained
" 模板TODO
syntax keyword qmtTodo TODO FIXME XXX contained
" 模板变量
syntax match qmtVariable /\$[a-zA-Z0-9][a-zA-Z0-9_]*\$/ contains=qmtGlobalVar contained
" 全局变量
syntax match qmtGlobalVar /DATA\|uid\|username/ contained
" 注释
syntax region qmtComment start=/<%##/ end=/##%>/ contains=qmtTodo

" TODO 增加更多错误检测
" 模板标签错误
syntax match qmtTagError /%>\|<[^%][^%]*%>\|<%[^%]*[^%]>\|<%@%\|<%%/
" 结构语句错误
syntax match qmtStatementError /<%\s*\(if\|else\|elseif\|endif\|for\|endfor\)\s*[(%]/

" 为与html配合而做的额外处理
" 重新定义html标签，使其可以包含qmt模板标签
syntax region htmlTag start=+<[^/%]+ end=+>+ contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,javaScript,qmtNodeName,qmtFuncTagBlock,qmtComment
" 让字符串内可包含qmt
syntax region htmlString start=/"/ end=/"/ contains=qmtNodeName,qmtFuncTagBlock,qmtComment

if version >= 508 || !exists("did_qmt_syn_inits")
  if version < 508
    let did_django_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink qmtComment Comment

  HiLink qmtTagNode PreProc
  HiLink qmtTagSec PreProc
  HiLink qmtTagFunc PreProc
  HiLink qmtFuncTagBlock Function

  HiLink qmtNodeName Identifier
  HiLink qmtSection Identifier
  HiLink qmtVariable Identifier
  HiLink qmtFuncName Identifier

  HiLink qmtStatement Statement

  HiLink qmtGlobalVar Special

  HiLink qmtNumber Number
  HiLink qmtHtmlString String

  HiLink qmtTagError Error
  HiLink qmtStatementError Error
  HiLink qmtTodo Todo

  delcommand HiLink
endif

let b:current_syntax = "qmt"
