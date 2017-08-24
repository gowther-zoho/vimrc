"===[ Turn it all on ]===
runtime macros/matchit.vim

if !exists("g:syntax_on")
    syntax enable
endif

filetype plugin indent on

set omnifunc=syntaxcomplete#Complete

"===[ Determin OS to determine VIMHOME ]===
if has('win32') || has ('win64')
    let $VIMHOME = $VIM."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif

"===[ Map the leader key ]===
let mapleader=","
let g:mapleader=","

"===[ Keycodes and maps timeout in 3/10 sec ]===
set timeout timeoutlen=300 ttimeoutlen=300

"===[ Quick edit of the vimrc ]===
nnoremap <leader>ev  :edit! $MYVIMRC<cr>

"===[ Auto-update after the vimrc is edited ]===
augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd BufWritePost $MYVIMRC echom 'vimrc reloaded'
augroup END

"===[ Source help files ]===
nnoremap <leader>ht  :helptags ALL<cr>

"===[ Easier completion ]===
set infercase
inoremap <leader><leader> <C-P>

"===[ Make yank more intuitive ]===
nnoremap Y y$

"===[ move to beginning/end of line ]===
nnoremap B ^
nnoremap E $

"===[ Indent entire file per syntax setting ]===
nnoremap <leader>i  <esc>gg=G<cr>

"===[ Indent code block ]===
nnoremap <leader>c  <esc>=aB<cr>

"===[ Make vaa select the entire file ]===
vnoremap aa VGo1G

"===[ Most recently used files ]===
nnoremap <leader>rf  :bro ol<cr>

"===[ Browse buffers better ]===
nnoremap <leader>b :ls<cr>:b<space>

"===[ Setup a secure file to encrypt 'secret' stuff ]===
set cm=blowfish2
autocmd BufReadPost * if &key != "" | set readonly noswapfile nowritebackup noundofile viminfo= nobackup noshelltemp history=0 secure | endif
nnoremap <leader>v   :edit! $VIMHOME/vault/vault.yaml<cr>

"===[ Backups ]===
set backup
set backupdir=$VIMHOME/backup
set directory=$VIMHOME/swap

"===[ Undo with tree ]===
set undodir=$VIMHOME/undo
set undofile
set undolevels=3000
set undoreload=1000
nnoremap <leader>u :UndotreeToggle<cr>

"===[ Only show cursorline in the current window and in normal mode ]===
augroup cline
    autocmd!
    autocmd WinLeave,InsertEnter * set nocursorline
    autocmd WinEnter,InsertLeave * set cursorline
augroup END

"===[ Use space to jump down a page (like browsers do) ]===
nnoremap <Space> <PageDown>
vnoremap <Space> <PageDown>

"===[ Default options for files ]===
set encoding=utf-8
set ff=unix
set fileencoding=utf-8
set fileformats=unix,dos

"===[ Set search options ]===
set ignorecase
set incsearch
set nohlsearch
set smartcase
nnoremap <F9>  :set hlsearch! hlsearch<cr>

"===[ Use sane regexes ]===
nnoremap / /\v
vnoremap / /\v

"===[ how tabs work etc ]===
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround

"===[ Editor defaults ]===
set textwidth=78
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set clipboard=unnamed
set foldmethod=marker
set formatoptions=qrnlj
set hidden
set history=1000
set iskeyword+=$,%,#,:
set lazyredraw
set matchpairs+=<:>,?:?
set matchtime=5
set noerrorbells
set nofoldenable
set nojoinspaces
set noshowmode
set notimeout
set nowrap
set nrformats-=octal
set shortmess=atI
set showcmd
set showmatch
set spelllang=en_us
set t_vb=
set title
set ttimeout
set ttimeoutlen=10
set ttyfast
set updatecount=30
set visualbell
set modeline

"===[ Diff options ]===
set diffopt+=iwhite
let g:diffwhitespaceon = 0

function! ToggleDiffWhitespace()
    if g:diffwhitespaceon
        set diffopt-=iwhite
        let g:diffwhitespaceon = 0
    else
        set diffopt+=iwhite
        let g:diffwhitespaceon = 1
    endif
    diffupdate
endfunction

"===[ Scrolling ]===
set scrolloff=2
set sidescroll=1
set sidescrolloff=2

"===[ Better completion ]===
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

"===[ Vim list stuff ]===
set listchars=eol:¬,tab:→→,extends:>,precedes:<
set nolist
set linebreak
let &showbreak='> '

"===[ viminfo config ]===
"           +--Disable hlsearch while loading viminfo
"           | +--Remember marks for last 500 files
"           | |    +--Remember up to 10000 lines in each register
"           | |    |      +--Remember up to 1MB in each register
"           | |    |      |     +--Remember last 1000 search patterns
"           | |    |      |     |     +===Remember last 1000 commands
"           | |    |      |     |     |
"           v v    v      v     v     v
set viminfo=h,'500,<10000,s1000,/1000,:1000

"===[ Save when focus lost ]===
autocmd FocusLost * :silent! wall

"===[ Wildmode/Wildmenu ]===
set wildmenu
set wildmode=list:longest,full

"===[ netrw better defaults ]===
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_liststyle=3
let g:netrw_sort_by='time'
let g:netrw_sort_direction='reverse'
let g:netrw_winsize=30
set autochdir
nnoremap <leader>x   :Lexplore<cr>
nnoremap <leader>sx  :Sexplore<cr>

"===[ Resize splits in a sane way ]===
autocmd VimResized * :wincmd =

"===[ Commands for adjusting indentation rules manually ]===
command! -nargs=1 Spaces execute "setlocal tabstop=" . <args> . " shiftwidth=" . <args> . " softtabstop=" . <args> . " expandtab" | setlocal ts? sw? sts? et?
command! -nargs=1 Tabs   execute "setlocal tabstop=" . <args> . " shiftwidth=" . <args> . " softtabstop=" . <args> . " noexpandtab" | setlocal ts? sw? sts? et?

"===[ Statusline ]===
set laststatus=2
set statusline=
set statusline+=\%{WhatMode()}
set statusline+=%<%.20f%m%r%h%w
set statusline+=%=
set statusline+=\ [%n]
set statusline+=\ [%{&ft}]
set statusline+=\ [%{&ff}]
set statusline+=\ [%{&fenc}]
set statusline+=\ [%{&ts},%{&sw},%{&sts}]
set statusline+=\ [%l/%L,%c%{CheckColumn()}]
set statusline+=\ [%P]

"===[ Set colorscheme ]===
colorscheme default

"===[ Options for GUI Vim ]===
if has("gui_running")
    set clipboard=unnamed
    set cmdheight=2
    set guifont=Courier_New:h15
    set guioptions-=lLrRT
    set guioptions=acemgt
    set lines=50
    set columns=95
    set mouse=a
    set mousehide
    set mousemodel=popup
    set number
    set numberwidth=5
    set selectmode=mouse
    colorscheme apprentice
    set vb t_vb=
    autocmd FocusGained * :redraw!
endif

"===[ minisnips ]===
let g:minisnip_dir = $VIMHOME . '/snippets'
let g:minisnip_startdelim = '||+'
let g:minisnip_enddelim = '+||'

augroup MiniSnip
    autocmd!
    autocmd BufRead,BufNewFile ~/.vim/snippets/* set filetype=minisnip
augroup END

"===[ mru ]===
let MRU_Max_Menu_Entries=40
let MRU_Max_Submenu_Entries=20
nnoremap <leader>m :call MRU<cr>

"===[ todo.txt ]===
nnoremap <leader>tt  :edit! $VIMHOME/todo/todo.txt<cr>
nnoremap <leader>td  :edit! $VIMHOME/todo/done.txt<cr>

"===[ Automatically remove trailing whitespace ]===
autocmd BufWritePre * :%s/\s\+$//e

"==[ Two spaces after end of sentence punctuation! ]===
autocmd BufRead * :set cpoptions+=J

"===[ Groupings ]===
augroup PerlFiles
    autocmd!
    autocmd BufNewFile,BufRead *.t set filetype=perl
    autocmd FileType perl set expandtab tabstop=4 softtabstop=4 shiftwidth=4
    autocmd FileType perl set makeprg=perl\ -cw\ %\ $*
    autocmd FileType perl set errorformat=%f:%l:%m
    autocmd FileType perl let [perl_include_pod, perl_extended_vars] = [1, 1]
    autocmd FileType perl let perl_include_pod=1
    autocmd FileType perl let perl_extended_vars=1
augroup END

augroup TclFiles
    autocmd!
    autocmd BufNewFile,BufRead *.test set filetype=tcl
augroup END

augroup PythonFiles
    autocmd!
    autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent
    autocmd FileType python set fileformat=unix
    autocmd FileType python let python_highlight_all=1
augroup END

augroup ShellFiles
    autocmd!
    autocmd FileType sh set tabstop=2 shiftwidth=2 softtabstop=2
augroup END

augroup TodoFiles
    autocmd!
    autocmd FileType todo set fileformat=dos tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    autocmd FileType todo nnoremap <leader>pd :call PastDue()<cr>
    autocmd FileType todo let g:todo_load_python = 0
augroup END

augroup JavascriptFiles
    autocmd!
    autocmd BufRead,BufNewFile *.jjs,*.jjsp set filetype=javascript
augroup END

augroup ModeModifiers
    autocmd!
    autocmd FileTYpe html let [html_indent_script1, html_indent_style1] = ["inc", "inc"]
    autocmd FileType java let java_highlight_all=1
augroup END

"=== FUNCTION ========================================
"        NAME: ConditionalPairMap
" DESCRIPTION: This matches character pairs that are
"              defined.
"=====================================================
function! ConditionalPairMap(open, close)
    let line = getline('.')
    let col = col('.')
    if col < col('$') || stridx(line, a:close, col + 1) != -1
        return a:open
    else
        return a:open . a:close . repeat("\<left>", len(a:close))
    endif
endfunction
inoremap <expr> ( ConditionalPairMap('(', ')')
inoremap <expr> { ConditionalPairMap('{', '}')
inoremap <expr> [ ConditionalPairMap('[', ']')

"=== FUNCTION ========================================
"        NAME: DeleteBlankLines
" DESCRIPTION: This function deletes ALL blank lines
"              in the source file.
"=====================================================
function! DeleteBlankLines()
    exe "normal mz"
    %g/^\s*$/d
    exe "normal `z"
endfunction
nnoremap <leader>dbl :call DeleteBlankLines()<cr>

"=== FUNCTION ========================================
"        NAME: DeleteTrailingSpaces
" DESCRIPTION: This function deletes ALL trailing
"              spaces in the source file.
"=====================================================
function! DeleteTrailingSpaces()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunction
nnoremap <leader>dts :call DeleteTrailingSpaces()<cr>

"=== FUNCTION ========================================
"        NAME: DosToUnix
" DESCRIPTION: This function deletes ALL the ^M junk
"=====================================================
function! DosToUnix()
    exe "normal mz"
    %s/\r\+$//ge
    exe "normal `z"
endfunction
nnoremap <leader>dtu :call DosToUnix()<cr>

"=== FUNCTION ========================================
"        NAME: TakeNote
" DESCRIPTION: Executing :TNT <filename> will save your
"              file as <filename>_YYYY-MM-DD_HH-MM.txt.
"=====================================================
function! TakeNote(filename) range
    let l:extension = '.' . fnamemodify( a:filename, ':edit' )
    if len(l:extension) == 1
        let l:extension = '.txt'
    endif

    let l:filename = escape( fnamemodify(a:filename, ':r') . strftime("_%Y%m%d_%H%M") . l:extension, ' ' )

    execute "write " . "$VIMHOME/notes/" . l:filename
endfunction
command! -nargs=1 TNT call TakeNote( <q-args> )

"=== FUNCTION ========================================
"        NAME: WhatMode
" DESCRIPTION: Show mode in the statusline
"=====================================================
function! WhatMode()
    let s:MyMode=mode()
    if s:MyMode == 'n'
        return "[NRM] "
    elseif s:MyMode == 'i'
        return "[INS] "
    elseif s:MyMode == 'v'
        return "[VIS] "
    elseif s:MyMode == 'c'
        return "[CMD] "
    endif
endfunction

"=== FUNCTION ========================================
"        NAME: CheckColumn
" DESCRIPTION: Check the column vs textwidth and put
"              an asterisk after the column indicator
"              in the statusline.
"=====================================================
function! CheckColumn()
    let colnum = col('.')
    let twnum = &textwidth

    if colnum > twnum
        return "*"
    else
        return ""
    endif
endfunction

"=== FUNCTION ========================================
"        NAME: PastDue
" DESCRIPTION: Check if each due: item is current or
"              past due.
"=====================================================
function! PastDue()
    try
        " Search the buffer for the due: part of due:YYYY-MM-DD
        call search('due:')

        " Get due: to the end
        normal y$

        " Get the value in the register
        let due_variable = @0

        " Split it into a list
        let due_date =  split(due_variable, ':')

        " Get the date portion only
        let date_due = join(split(due_date[1],'-'), "")

        " Compare that date with today's date
        let date_today = strftime("%Y%m%d")
        let answer = date_today - date_due

        if answer == 0
            echo "The task is due today"
        elseif answer < 0
            echo "The task is still in the future"
        else
            echo "The task is past due"
        endif
    catch
        echo "No due items found"
    endtry
endfunction

"===[ Abbreviations ]===
iabbrev @a  Robert Hicks
iabbrev @r  rlhicks@wehicks.com
iabbrev @s  sigzero@gmail.com

"===[ Plugins ]===
"https://github.com/vim-scripts/todo-txt.vim.git
"https://github.com/mbbill/undotree
"https://github.com/yegappan/mru
"https://github.com/mattn/calendar-vim.git
"https://github.com/vim-perl/vim-perl6.git
"https://github.com/vim-perl/vim-perl.git
"https://github.com/joereynolds/vim-minisnip.git
"https://github.com/romainl/Apprentice.git
