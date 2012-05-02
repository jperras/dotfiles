" some new highlight groups
hi PyDocString guifg=DarkSlateBlue
hi RstDocStringKeywords guifg=firebrick gui=underline,bold
hi RstParam guifg=SlateBlue gui=italic

"Number of spaces to use for each step of (auto)indent.
setlocal shiftwidth=2
"Number of spaces that a <Tab> in the file counts for.
setlocal tabstop=2
"Use the appropriate number of spaces to insert a <Tab>
setlocal expandtab

" Load the ReST syntax file; but first we clear the current syntax
" definition, as rst.vim does nothing if b:current_syntax is defined.
let s:current_syntax=b:current_syntax
unlet b:current_syntax
" Load the ReST syntax file
syntax include @ReST $VIMRUNTIME/syntax/rst.vim
let b:current_syntax=s:current_syntax
unlet s:current_syntax

" clear the rstLiteralBlock
" TODO: improve this; this should apply to all
" pythonDocString regions but the rstParameterDefinition regions
syntax clear rstLiteralBlock

" By using the nextgroup argument below, we are giving priority to
" pythonDocString over all other groups. This means that a pythonDocString
" can only begin a :
syntax match beginPythonBlock ":$" nextgroup=pythonDocString skipempty skipwhite
hi link beginPythonBlock None

syntax region pythonDocString
    \ start=+[uUr]\='+
    \ end=+'+
    \ contains=rstParameterDefinition,pythonEscape,@Spell,@ReST,rstDocStringKeywords
    \ contained
    \ fold
syntax region pythonDocString
    \ start=+[uUr]\="+
    \ end=+"+ 
    \ contains=rstParameterDefinition,pythonEscape,@Spell,@ReST,rstDocStringKeywords
    \ contained
    \ fold
syntax region pythonDocString
    \ matchgroup=PyDocString
    \ start=+[uUr]\="""+
    \ end=+"""+
    \ contains=rstParameterDefinition,pythonEscape,@Spell,@ReST,rstDocStringKeywords,rstInputs
    \ contained
    \ skipempty
    \ skipwhite
    \ keepend
    \ fold
syntax region pythonDocString
    \ matchgroup=PyDocString
    \ start=+[uUr]\='''+
    \ end=+'''+
    \ contains=rstParameterDefinition,pythonEscape,@Spell,@ReST,rstDocStringKeywords
    \ contained
    \ skipempty
    \ skipwhite
    \ keepend
    \ fold
hi link pythonDocString PyDocString

" clear the pythonDoctest and pythonDoctestValue syntax groups
syntax clear pythonDoctest
syntax clear pythonDoctestValue

syntax region rstParameterDefinition start=":param" end=":" contains=ALLBUT,rstParameterDefinition,@ReST,@Spell contained
hi link rstParameterDefinition RstParam

syntax case match
syntax keyword rstDocStringKeywords TODO BUG TEST REFACTOR
hi link rstDocStringKeywords RstDocStringKeywords

" Look back at least 200 lines to compute the syntax highlighting
syntax sync minlines=200
