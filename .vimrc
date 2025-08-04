set nocompatible

set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=50
set signcolumn=auto
set colorcolumn=100

set number
set relativenumber

set smartindent
set tabstop=2
set expandtab
set shiftwidth=2

set cursorline

set ignorecase
set smartcase

set showcmd
set showmode

set hlsearch

set history=1000

set path+=**
set wildmenu
" set wildmenu=list:longest
" set guicursor=i:hor20-BlinkOn0

filetype on
filetype plugin on
filetype indent on

syntax on

" Auto-install vim-plug if missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged') " Plugin directory

Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'npm ci'} 
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'berdandy/ansiesc.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', 

call plug#end()

if exists(':PlugInstall')
  if isdirectory(expand('~/.vim/plugged/dracula'))
    colorscheme dracula
    set termguicolors
  else
    colorscheme default
  endif
else
  colorscheme default
endif

" Coc Extensions 
let g:coc_global_extensions = [
  \ 'coc-yaml',
  \ 'coc-pyright',
  \ 'coc-json',
  \ 'coc-git',
  \ 'coc-sh',
  \ 'coc-prettier',
  \ 'coc-flutter',
  \ 'coc-explorer',
  \ 'coc-clangd',
  \ ]
let g:coc_disable_startup_warning = 1
set cmdheight=2

set guioptions-=r
set guioptions-=L
set scrolloff=8

" MAPPINGS -------------------------------------------------- {{{

let mapleader = "\<space>"
inoremap jj <ESC>
nnoremap <leader>o o<ESC>
nnoremap <leader>O O<ESC>
nnoremap Y y$
nnoremap <c-d> :bot term<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '>-2<CR>gv=gv

nnoremap <leader>pv :Ex<CR>
nnoremap <leader>rec :browse oldfiles<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>gf :GFiles<CR>

" }}}


" Coc Appearance {{{

" hi CocFloating ctermbg=236 ctermfg=231 guibg=#282a36 guifg=#f8f8f2
hi cocmenusel ctermbg=61 ctermfg=231 guibg=#bd93f9 guifg=#f8f8f2
hi CocFloating guisp=#44475a gui=standout
if has('gui_running')
  set winblend=10
  hi CocFloating gui=shadow:2,sharp
endif

"hi cocinlayhint gui=italic cterm=italic ctermbg=235 ctermfg=245 guibg=#44475a guifg=#6272a4
hi cocinlayhinttype gui=italic cterm=italic ctermbg=235 ctermfg=117 guibg=#44475a guifg=#8be9fd
hi CocInlayHintParameter gui=italic cterm=italic ctermbg=235 ctermfg=215 guibg=#44475a guifg=#ffb86c

hi CocErrorHighlight ctermfg=203 guifg=#ff5555
hi CocWarningHighlight ctermfg=215 guifg=#ffb86c
hi CocInfoHighlight ctermfg=117 guifg=#8be9fd
 
" autocmd FileType * call matchadd('CocInlayHint', '^\s*.\{-}\ze\s*[;,]', 0, -1)
" }}}

" Coc mappings {{{

" Use <Tab> to move down in coc menus and <S-Tab> to move up.
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackSpace() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<c-h>"
inoremap <silent><expr> <c-space> coc#refresh()

" Use Return to confirm selected choice in coc menus.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> K :call CocActionAsync('doHover')<CR>
" Go Back
nmap <silent> gb <C-o> 
" trigger code actions.
nmap <silent> ,ca <Plug>(coc-codeaction)
nmap <silent> ,cr <Plug>(coc-refactor)
nmap <silent> ,cc <Plug>(coc-toggle-comment)

" show the hilight name of the word under the cursor
noremap ,<C-g> :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>

" Use ctrl with j, and k to move in the coc menu down and up, f, and b to move 
" page down and up while in insert mode
inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"
inoremap <expr> <C-f> coc#pum#visible() ? "\<PageDown>" : "\<Right>"
inoremap <expr> <C-b> coc#pum#visible() ? "\<PageUp>" : "\<Left>"

" Use ctrl with j, and k to navigate the coc menu in normal mode
nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1, 1) : "\<C-j>" 
nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0, 1) : "\<C-k>" 

" Use alt with j, and k to scroll documentation popups in insert mode
execute "set <A-h>=\eh"
execute "set <A-j>=\ej"
execute "set <A-k>=\ek"
execute "set <A-l>=\el"
inoremap <silent><nowait><expr> <A-j> coc#float#has_scroll() ? coc#float#scroll(1, 1) : "\<A-j>" 
inoremap <silent><nowait><expr> <A-k> coc#float#has_scroll() ? coc#float#scroll(0, 1) : "\<A-k>" 

nnoremap <silent> <space>e :CocCommand explorer<CR>

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

"Renaming
nmap ,rn <Plug>(coc-rename)

xmap ,f <Plug>(coc-format-selected)
nmap ,ff <Plug>(coc-format)

" }}}

nnoremap <silent> <space>e :CocCommand explorer<CR>


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

function! CheckBackSpace() abort
  let col=col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction


autocmd FileType java nnoremap <expr> cc getline(".") =~ '\s*\/\/' ? '^2x' : 'I//<ESC>'
autocmd FileType python nnoremap <expr> cc getline(".") =~ '\s*# ' ? '^2x' : 'I# <ESC>'
autocmd FileType bash nnoremap <expr> cc getline(".") =~ '\s*# ' ? '^2x' : 'I# <ESC>'
autocmd FileType vim setlocal foldmethod=marker 

augroup flutter_coc
  autocmd!
  " autocmd FileType dart nnoremap <silent> ,fr :call CocAction('runCommand', 'flutter.dev.hotReload')<CR>
  autocmd FileType dart nnoremap <silent> ,fr :call flutter#runner#hot_reload()<CR>
  " autocmd FileType dart nnoremap <silent> ,fR :call CocAction('runCommand', 'flutter.dev.hotRestart')<CR>
  autocmd FileType dart nnoremap <silent> ,fR :call flutter#runner#hot_restart()<CR>
  autocmd FileType dart nnoremap <silent> ,fd :call CocAction('runCommand', 'flutter.devices')<CR>
  autocmd FileType dart nnoremap <silent> ,fe :call CocAction('runCommand', 'flutter.emulators')<CR>
  "autocmd FileType dart nnoremap <silent> ,fq :call CocAction('runCommand', 'flutter.dev.quit')<CR>
  autocmd FileType dart nnoremap <silent> ,fq :call flutter#runner#stop()<CR>
  autocmd FileType dart nnoremap <silent> ,fo :call CocAction('runCommand', 'flutter.dev.openDevToolsProfiler')<CR>
  autocmd FileType dart nnoremap <silent> ,fc :CocCommand flutter.run<CR>
  " autocmd FileType dart nnoremap <silent> ,fs :call FlutterRun()<CR>
  autocmd FileType dart nnoremap <silent> ,fs :call FlutterSelectDevice()<CR>
  autocmd FileType dart nnoremap <silent> ,fl :call flutter#runner#toggle_logs()<CR>
augroup END

" autocmd BufEnter * echo 'FileType: [' . &ft . ']'

" Copy file path and file name to vim register instead of the clipboard. for
" unsupported clipboard
nnoremap yp :if &ft ==# 'coc-explorer' \| call CopyFilePath() \| else \| echo '' \| endif<CR>
nnoremap yn :if &ft ==# 'coc-explorer' \| call CopyFileName() \| else \| echo '' \| endif<CR>

" Flutter Functions {{{
function! FlutterSelectDevice()
  "Get device list
  let devices_output = system('flutter devices --machine')
  if v:shell_error != 0
    echoh1 ErrorMsg
    echo "Error getting devices: " . devices_output
    echoh1 None
    return
  endif
  
  try
    let g:flutter_devices = json_decode(devices_output)
  catch
    echoh1 ErrorMsg
    echo "Failed to parse devices: " .v:exception
    echoh1 None
    return
  endtry
  
  if empty(g:flutter_devices)
    echo "No devices available"
    return
  endif

  " prepare content for floating window
  let content = ['None']
  let index = 0
  for device in g:flutter_devices
    let device_type = has_key(device, 'platform') ? device['platform'] : device['id']
    let icon = s:GetDeviceIcon(device_type)
    call add(content, (index + 1) . '. ' . icon . device['name'] . ' (' . device['id'] . ')')
    let index += 1
  endfor

    "Create floating window
  let popup = popup_create(content, {
    \ 'title' : 'Select Flutter Device',
    \ 'line': 0,
    \ 'col': 0,
    \ 'zindex': 200,
    \ 'drag': 1,
    \ 'border': [1, 1, 1, 1],
    \ 'cursorline': 1,
    \ 'padding': [1, 1, 0, 1],
    \ 'mapping': 0,
    \ 'minwidth': max(map(copy(content), {_,v -> len(v)})) + 4,
    \ 'filter': 'PopupFilter',
    \ 'callback': 'SelectDeviceAction',
    \ })

  call feedkeys("\<C-w>w", 'n')
endfunction

function! SelectDeviceAction(...)
  if a:0 < 2 || a:2 != 1  
    return 
  endif

  let line = line('.', a:1)

  let selection = line - 2
  
  if selection < 0 || selection >= len(g:flutter_devices)
    call popup_close(a:1)
    return
  endif

  let device = g:flutter_devices[selection]
  call popup_close(a:1)

  " execute 'CocCommand flutter.run -d ' . device['id']
  call flutter#runner#start(device['id'])
endfunction

function! PopupFilter(winid, key)
  if a:key == 'j' || a:key == '<Down>'
    call win_execute(a:winid, 'normal! j')
    return 1
  elseif a:key == 'k' || a:key == '<Up>'
    call win_execute(a:winid, 'normal! k')
    return 1
  endif

  if a:key == "\<CR>"
    call popup_close(a:winid, 1)
    return 1
  elseif a:key == "\<Esc>" || a:key == 'q'
    call popup_close(a:winid, 0)
    return 1
  endif

  return 0
endfunction

" native vim selection {{{
function! FlutterRun()
  " let devices = CocAction('runCommand', 'flutter.devices', 1)
  let devices_output = system('flutter devices --machine')

  if empty(devices_output)
    echo "No devices found"
    return
  endif

  try
    let devices = json_decode(devices_output)
  catch
    echoh1 ErrorMsg
    echo "Failed to parse devices: " . v:exception
    echoh1 None
    return
  endtry

  let choices = []
  let index = 1
  for device in devices
    let entry = index . '. ' . device['name'] . ' (' . device['id'] . ')'
    call add(choices, entry)
    let index += 1
  endfor

  let selection = inputlist(['Select device:'] + choices)

  if selection < 1 || selection > len(choices)
    echo "Cancelled"
    return
  endif

  "let device_id = split(choices[selection-1], ' ')[-1]
  "let device_id = substitute(device_id, '[()]', '', 'g')

  let device_id = devices[selection-1]['id']
  "echo "devices list: " . devices_output 
  "echo "device id before substitute: " . device_id
  "let device_id = substitute(device_id, '^[''"]\+', '', '')
  "let device_id = substitute(device_id, '[''"]\$', '', '')

  execute 'CocCommand flutter.run -d ' . device_id
  echo "device id: " . shellescape(device_id)
endfunction

"}}}

if has('popupwin')
  hi pmenu guibg=#232530
  hi pmenuSel guibg=#44475a
endif
"}}}

" Font tools {{{
let s:device_icons = {
      \ 'android': '📱',
      \ 'ios': '',
      \ 'web': '🌐',
      \ 'linux': '🐧',
      \ 'windows': '🪟',
      \ 'macos': '🍎',
      \ 'chrome': '🖥️',
      \ 'edge': '🌍',
      \ 'firefox': '🦊',
      \ 'safari': '🧭',
      \ 'default': '📟'
      \ }

let g:flutter_custom_icons = {
      \ 'linux': '🐧',
      \ 'web': '🌍',
      \ 'android': '🤖',
      \ 'ios': '🍎',
      \ 'default': '💻'
      \ }

function! s:GetDeviceIcon(device)
  if !exists('s:has_nerd_font')
    let s:has_nerd_font = s:HasNerdFont()
  endif
  if s:has_nerd_font
    let nerd_icons = {
       \ 'android': '',
       \ 'ios': '',
       \ 'web': '',
       \ 'linux': '',
       \ 'windows': '',
       \ 'macos': '',
       \ 'chrome': '',
       \ 'edge': '',
       \ 'firefox': '',
       \ 'safari': '',
       \ 'default': ''
      \ }
    let icon = get(nerd_icons, tolower(a:device), nerd_icons['default'])
    return icon . ' '
  endif

  let emoji_icon = get(s:device_icons, tolower(a:device), s:device_icons['default'])
  return emoji_icon . ' '
endfunction

function! s:HasNerdFont()
  " Save current position
  let save_pos = getpos('.')
  let save_reg = getreg('a')
  
  try
    " Create test buffer
    new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    call setline(1, '')
    
    " Capture rendered output
    let output = ''
    redir => output
    silent! 1print
    redir END
    
    " Clean up
    close!
  finally
    call setpos('.', save_pos)
    call setreg('a', save_reg)
  endtry
  
  " Check if glyph appears in output
  return output =~ ''
endfunction

command! CheckNerdFont echo "Nerd Font supported: " . (s:HasNerdFont() ? "YES" : "NO")

" }}}

" file-explorer functions {{{

function! CopyFilePath() abort
  let node = CocAction('runCommand', 'explorer.getNodeInfo', 0)
  if !empty(node)
    let path = node['fullpath']->fnamemodify(':.')  " Relative path
    let @" = path  " Yank to default register
    "let @* = path  " Try to set primary selection (might still fail)
    echo 'Copied: ' . path
  endif
endfunction

function! CopyFileName() abort
  let node = CocAction('runCommand', 'explorer.getNodeInfo', 0)
  if !empty(node)
    let name = fnamemodify(node['fullpath'], ':t')
    let @" = name
    "let @* = name
    echo 'Copied: ' . name
  endif
endfunction

" }}}

