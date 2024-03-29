" edit my vimrc 
let mapleader = "-"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" commenr code 
autocmd BufNewFile,BufRead *.py,*.sh   nnoremap <buffer> <leader>c I#<esc>
autocmd BufNewFile,BufRead *.py,*.sh   vnoremap <buffer> <leader>c I#<esc>

" status line


" abbreviations
:iabbrev @@    constmyheart@163.com
:iabbrev ccopy Copyright 2019 Pedro Qin, all rights reserved.

" Default Indentation
" set autoindent
" set smartindent     "indent when
set tabstop=4       "tab width
set softtabstop=4   "backspace
set shiftwidth=4    "indent width
set expandtab       "expand tab to space
set shiftround      

" read/write a .viminfo file, don't store more
" than 500 lines of registers
set viminfo='20,\"500	
" keep 50 lines of command line history
set history=500
set ruler
set rulerformat=%15(%c%V\ %p%%%)


set showmatch

" Enhanced Mode 's command 's auto complete
set wildmenu

" enable mouse , other parameter: n , v , i , c 
" set mouse=a



" highlight current line
" au WinLeave * set nocursorline nocursorcolumn
" au WinEnter * set cursorline cursorcolumn
" set cursorline cursorcolumn
"
" search
set incsearch
" set ignorecase
set hlsearch

" auto complete function, need open the File type detection function
" filetype plugin indent on
" filetype on


"""""""""
nnoremap ; :
command W w
command WQ wq
command Wq wq
command Q q
command Qa qa
command QA qa

function HappyPython()
    echom "Insert Python header !"
    call setline(1, "#!/usr/bin/env python")
    call append(1, "#-*- coding:utf8 -*-")
    call append(2,"###############################################")
    call append(3,"# Filename    :   " . expand("%:t"))
    call append(4,"# Author      :   PedroQin")
    call append(5,"# Email       :   constmyheart@163.com")
    call append(6,"# Date        :   " . strftime("%Y-%m-%d %H:%M:%S"))
    call append(7,"# Description :   ")
    call append(8,"###############################################")
    call append(9," ")
    " normal G
    " normal o
endfunction
"autocmd bufnewfile *.py call HappyPython()
function HappyShell()
    echom "Insert shell header !"
    call setline(1, "#!/bin/bash")
    call append(1,"###############################################")
    call append(2,"# Filename    :   " . expand("%:t"))
    call append(3,"# Author      :   PedroQin")
    call append(4,"# Email       :   constmyheart@163.com")
    call append(5,"# Date        :   " . strftime("%Y-%m-%d %H:%M:%S"))
    call append(6,"# Description :   ")
    call append(7,"###############################################")
    call append(8," ")
    " normal G
    " normal i
endfunction
"autocmd bufnewfile *.sh call HappyShell()

function Title()
    echom "Title update !"
    let n=1
    while n < 10
        let line = getline(n)
        if line =~ '\sDate'
            call SetLastModifiedTime(n)
            return
        endif
        let n = n + 1
    endwhile
    call append(5,"# Date        :   " . strftime("%Y-%m-%d %H:%M:%S"))
endfunction

function SetLastModifiedTime(lineno)  
    let modif_time = strftime("%Y-%m-%d %H:%M:%S")
    if a:lineno == "-1"  
            let line = getline(7)  
    else  
            let line = getline(a:lineno)  
    endif
    if line =~ '\sDate'
            let line = strpart(line, 0, stridx(line, ":")) . ":   " . modif_time
    endif  
    if a:lineno == "-1"  
            call setline(7, line)  
    else  
            call setline(a:lineno, line)  
    endif  
endfunction

function Version()
    echom "Verison update !"
    let n=1
    while n < 10
        let line = getline(n)
        if line =~ '\sVersion'
            call SetVersion(n)
            return
        endif
        let n = n + 1
    endwhile
    call SetVersion('-1')
endfunction

function SetVersion(lineno)
    if a:lineno == "-1"
        let line = getline(7)  
    else  
        let line = getline(a:lineno)  
    endif
    if line =~ '\sVersion'
        let subline= strpart(line, strridx(line, ".")+1) +1
        let line = strpart(line, 0, strridx(line, ".")) . '.' .  subline
    else
    endif  
    if a:lineno == "-1"  
        call append(7,"# Version     :   1.0.0")
    else  
        call setline(a:lineno, line)  
    endif  

endfunction

map <F1> : call HappyShell()<cr>
map <F2> : call HappyPython()<cr>
map <F5> : call Title()<cr>
map <F6> : call Version()<cr>

"/*========================================*\
""               常用指令收集
"\*========================================*/
""   系统时间
"   :map <F7> a<C-R>=strftime("%c")<CR><esc>
"   :s/__date__/\=strftime("%c")/

"/*---------------------------------------*\
"               基础命令
"/*---------------------------------------*\
"   ctrl+q              可以联合复制，粘贴，替换用 行操作
"   ctrl+w+j ctrl+w+k (:bn :bp :bd)

"   '.                  它移动光标到上一次的修改行
"   `.                  它移动光标到上一次的修改点
"   .                   重复上次命令
"   <C-O> :             依次沿着你的跳转记录向回跳 (从最近的一次开始)
"   <C-I> :             依次沿着你的跳转记录向前跳
"   ju(mps) :           列出你跳转的足迹
"   :history :          列出历史命令记录
"   :his c :            命令行命令历史
"   :his s :            搜索命令历史
"   q/ :                搜索命令历史的窗口
"   q: :                命令行命令历史的窗口
"   g ctrl+g            计算文件字符
"   {,}                 前进至上一段落前进至后一段落
"   gg,G(2G)            文件首
"   gd dw gf ga(进制转化)
"   gg=G 全篇自动缩进 , =G 单行缩进

"* ci[ 删除一对 [] 中的所有字符并进入插入模式
"* ci( 删除一对 () 中的所有字符并进入插入模式
"* ci< 删除一对 <> 中的所有字符并进入插入模式
"* ci{ 删除一对 {} 中的所有字符并进入插入模式
"* cit 删除一对 HTML/XML 的标签内部的所有字符并进入插入模式
"* ci” ci’ ci` 删除一对引号字符 (” 或 ‘ 或 `) 中所有字符并进入插入模式
"
"* vi[ 选择一对 [] 中的所有字符
"* vi( 选择一对 () 中的所有字符
"* vi< 选择一对 <> 中的所有字符
"* vi{ 选择一对 {} 中的所有字符
"* vit 选择一对 HTML/XML 的标签内部的所有字符
"* vi” vi’ vi` 选择一对引号字符 (” 或 ‘ 或 `) 中所有字符

"   crl+] 函数原型处 crl+t 回 ( ctags )
"   ctl+p 自动补全( 编辑状态 )
"   :X 加密保存( 要输入密码 )
"   ? /         (N n)
"   f(F,t) 查找字符
"   w(e) 移动光标到下一个单词.
"   5fx 表示查找光标后第 5 个 x 字符.
"   5w(e) 移动光标到下五个单词.

"   b 移动光标到上一个单词.
"   0 移动光标到本行最开头.
"   ^ 移动光标到本行最开头的字符处.
"   $ 移动光标到本行结尾处.
"   H 移动光标到屏幕的首行.
"   M 移动光标到屏幕的中间一行.
"   L 移动光标到屏幕的尾行.

"   c-f (即 ctrl 键与 f 键一同按下)
"   c-b (即 ctrl 键与 b 键一同按下) 翻页
"   c-d (下半页) c-u(上半页) c-e (一行滚动)
"   zz 让光标所在的行居屏幕中央
"   zt 让光标所在的行居屏幕最上一行
"   zb 让光标所在的行居屏幕最下一行


"   在 vi 中 y 表示拷贝, d 表示删除, p 表示粘贴.
"其中拷贝与删除是与光标移动命令
"   yw 表示拷贝从当前光标到光标所在单词结尾的内容.
"   dw 表示删除从当前光标到光标所在单词结尾的内容.
"   y0 表示拷贝从当前光标到光标所在行首的内容.
"   d0 表示删除从当前光标到光标所在行首的内容.
"   y$(Y) 表示拷贝从当前光标到光标所在行尾的内容.
"   d$(D) 表示删除从当前光标到光标所在行尾的内容.
"   yfa 表示拷贝从当前光标到光标后面的第一个a字符之间的内容.
"   dfa 表示删除从当前光标到光标后面的第一个a字符之间的内容.
"   s(S),a(A),x(X),D
"   yy 表示拷贝光标所在行.
"   dd 表示删除光标所在行.

"   5yy 表示拷贝光标以下 5 行.
"   5dd 表示删除光标以下 5 行.
"   y2fa 表示拷贝从当前光标到光标后面的第二个a字符之间的内容.
"   :12,24y 表示拷贝第12行到第24行之间的内容.
"   :12,y 表示拷贝第12行到光标所在行之间的内容.
"   :,24y 表示拷贝光标所在行到第24行之间的内容. 删除类似.
"   TAB 就是制表符, 单独拿出来做一节是因为这个东西确实很有用.
"   << 输入此命令则光标所在行向左移动一个 tab.
"   >> 输入此命令则光标所在行向右移动一个 tab.
"   5>> 输入此命令则光标后 5 行向右移动一个 tab.
"   :5>>(>>>) :>>(>>>)5
"   :12,24> 此命令将12行到14行的数据都向右移动一个 tab.
"   :12,24>> 此命令将12行到14行的数据都向右移动两个 tab.
"   :set shiftwidth=4 设置自动缩进 4 个空格, 当然要设自动缩进先.
"   :set sts=4 即设置 softtabstop 为 4. 输入 tab 后就跳了 4 格.
"   :set tabstop=4 实际的 tab 即为 4 个空格, 而不是缺省的 8 个.
"   :set expandtab 在输入 tab 后, vim 用恰当的空格来填充这个 tab.
"   :g/^/exec 's/^/'.strpart(line('.').' ', 0, 4) 在行首插入行号
"   set ai 设置自动缩进
"   5ia<esc> 重复插入5个a字符

"/*---------------------------------------*\
"               替换命令
"/*---------------------------------------*\
"   替换文字 2009-02-34 ----> 2009-02-34 00:00:00
"   :%s/\(\d\{4\}-\d\{2\}-\d\{2\}\)/\1 00:00:00/g

"   :s/aa/bb/g              将光标所在行出现的所有包含 aa 的字符串中的 aa 替换为 bb
"   :s/\/bb/g               将光标所在行出现的所有 aa 替换为 bb, 仅替换 aa 这个单词
"   :%s/aa/bb/g             将文档中出现的所有包含 aa 的字符串中的 aa 替换为 bb
"   :12,23s/aa/bb/g         将从12行到23行中出现的所有包含 aa 的字符串中的 aa 替换为 bb
"   :12,23s/^/#/            将从12行到23行的行首加入 # 字符
"   :%s/fred/joe/igc        一个常见的替换命令，修饰符igc和perl中一样意思
"   s/dick/joe/igc则        对于这些满足条件的行进行替换

"   :g/^\s*$/d              空行(空格也不包含)删除.
"   :%s/\r//g               删除DOS方式的回车^M
"   :%s/ *$//               删除行尾空白(%s/\s*$//g)
"   :g!/^dd/d               删除不含字符串'dd'开头的行
"   :v/^dd/d                同上,译释：v == g!，就是不匹配！
"   :v/./.,/./-1join        压缩空行(多行空行合并为一行)
"   :g/^$/,/./-j            压缩空行(多行空行合并为一行)
"   :g/^/pu _               把文中空行扩增一倍 (pu = put),原来两行间有一个空行，现在变成2个
"   :g/^/m0                 按行翻转文章 (m = move)
"   :g/fred/,/joe/d         not line based (very powerfull)
"   :g/<input\|<form/p      或者 要用\|
"   :g/fred/t$              拷贝行，从fred到文件末尾(EOF)

"   :%norm jdd
"   隔行删除,译释：%指明是对所有行进行操作,norm指出后面是normal模式的指令,j是下移一行，dd是删除行

"   :'a,'bg/fred/s/dick/joe/igc   ('a,'b指定一个范围：mark a ~ mark b)
"
"   g//用一个正则表达式指出了进行操作的行必须可以被fred匹配,g//是一个全局显示命令

"   /joe/e                  光标停留在匹配单词最后一个字母处
"   /joe/e+1                光标停留在匹配单词最后一个字母的下一个字母处
"   /joe/s                  光标停留在匹配单词第一个字母处
"   /^joe.*fred.*bill/      标准正则表达式
"   /^[A-J]\+/              找一个以A~J中一个字母重复两次或以上开头的行
"   /forum\(\_.\)*pent      多行匹配
"   /fred\_s*joe/i          中间可以有任何空白，包括换行符\n
"   /fred\|joe              匹配FRED或JOE
"   /\<fred\>/i             匹配fred,fred必须是一个独立的单词，而不是子串
"   /\<\d\d\d\d\>           匹配4个数字 \<\d\{4}\>

"   列，替换所有在第三列中的str1
"   :%s:\(\(\w\+\s\+\)\{2}\)str1:\1str2:
"   交换第一列和最后一列 (共4列)
"   :%s:\(\w\+\)\(.*\s\+\)\(\w\+\)$:\3\2\1:

"   全局(global)显示命令，就是用 :g＋正则表达式
"   译释： :g/{pattern}/{cmd}
"就是全局找到匹配的,然后对这些行执行命令{cmd}
"   :g/\<fred\>/
"显示所有能够为单词fred所匹配的行
"   :g/<pattern>/z#.5                           显示内容，还有行号
"   :g/<pattern>/z#.5|echo '=========='         漂亮的显示

"/*---------------------------------------*\
"           多文档操作 (基础)
"/*---------------------------------------*\
"    用 :ls! 可以显示出当前所有的buffer
"   :bn                 跳转到下一个buffer
"   :bp                 跳转到上一个buffer
"   :wn                 存盘当前文件并跳转到下一个
"   :wp                 存盘当前文件并跳转到上一个
"   :bd                 把这个文件从buffer列表中做掉
"   :b 3                跳到第3个buffer
"   :b main             跳到一个名字中包含main的buffer

"/*---------------------------------------*\
"           列复制
"/*---------------------------------------*\
"   译注：@#%&^#*^%#$!
"   :%s= [^ ]\+$=&&= : 复制最后一列
"   :%s= \f\+$=&&= : 一样的功能
"   :%s= \S\+$=&& : ft,还是一样
"   反向引用，或称记忆
"   :s/\(.*\):\(.*\)/\2 : \1/ : 颠倒用:分割的两个字段
"   :%s/^\(.*\)\n\1/\1$/ : 删除重复行
"   非贪婪匹配，\{-}
"   :%s/^.\{-}pdf/new.pdf/ : 只是删除第一个pdf
"   跨越可能的多行
"   :%s/<!--\_.\{-}-->// : 又是删除多行注释（咦？为什么要说「又」呢？）
"   :help /\{-} : 看看关于 非贪婪数量符 的帮助
"   :s/fred/<c-r>a/g : 替换fred成register a中的内容，呵呵
"   写在一行里的复杂命令
"   :%s/\f\+\.gif\>/\r&\r/g | v/\.gif$/d | %s/gif/jpg/
"   译注：就是用 | 管道啦

"/*---------------------------------------*\
"           大小写转换
"/*---------------------------------------*\
"   g~~ : 行翻转
"   vEU : 字大写(广义字)
"   vE~ : 字翻转(广义字)
"   ~   将光标下的字母改变大小写
"   3~  将下3个字母改变其大小写
"   g~w 字翻转
"   U   将可视模式下的字母全改成大写字母
"   gUU 将当前行的字母改成大写
"   u   将可视模式下的字母全改成小写
"   guu 将当前行的字母全改成小写
"   gUw 将光标下的单词改成大写。
"   guw 将光标下的单词改成小写。


"   文件浏览
"   :Ex : 开启目录浏览器，注意首字母E是大写的
"   :Sex : 在一个分割的窗口中开启目录浏览器
"   :ls : 显示当前buffer的情况
"   :cd .. : 进入父目录
"   :pwd
"   :args : 显示目前打开的文件
"   :lcd %:p:h : 更改到当前文件所在的目录
"    译释：lcd是紧紧改变当前窗口的工作路径，% 是代表当前文件的文件名,
"    加上 :p扩展成全名（就是带了路径），加上 :h析取出路径

"/*========================================*\
"                   END
"\*========================================*/
