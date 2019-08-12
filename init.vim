" configuraciòn neovim - justo manrique
" última actualizaciòn: 01/08/2019

" Configuraciones iniciales
syntax on
set number
set encoding=utf-8
filetype plugin on

" Instalación de plugins neovim/vim
call plug#begin()
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'scrooloose/nerdtree'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'vim-syntastic/syntastic'
Plug 'jpalardy/vim-slime'
Plug 'autozimu/LanguageClient-neovim', {'branch':'next','do': 'bash install.sh'}
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'kassio/neoterm'
call plug#end()

" Configuración de vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
set conceallevel=1

" Configuración de ultisnips
let g:UltiSnipsExpandTrigger = '<c-tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Configuración de NERDTree
autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror
autocmd VimEnter * wincmd w
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Configuración de syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint','python']
let g:syntastic_r_checkers=['lintr']
" Configuración de colores
colorscheme gruvbox-material-hard

" Configuración de colores lightline
let g:lightline = {'colorscheme' : 'gruvbox_material'}
let g:latex_to_unicode_auto = 1

" Configuración de vim-julia \ language-server
let g:default_julia_version = '1.0'
let g:LanguageClient_autoStart = 1
" language server
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
\   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       using Pkg;
\       import StaticLint;
\       import SymbolServer;
\       env_path = dirname(Pkg.Types.Context().env.project_file);
\       debug = false; 
\       
\       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
\       server.runlinter = true;
\       run(server);
\   ']
\ }
" Configuración de cocjson
autocmd FileType json syntax match Comment +\/\/.\+$+

"configuración languageclient-neovim

nnoremap <silent> K :call LanguageClient#textDocument_Hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" mappings de vim-slime
xmap <c-c><c-c> <Plug>SlimeRegionSend
nmap <c-c><c-c> <Plug>SlimeParagraphSend
nmap <c-c>v     <Plug>SlimeConfig

let g:slime_target = "neovim"

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lf <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Configuración neoterm
nmap gx <Plug>(neoterm-repl-send)
xmap gx <Plug>(neoterm-repl-send)
nmap gcx <Plug>(neoterm-repl-send)
let g:neoterm_autoscroll = 1

" Configuración cuando se abre archivos de julia
au BufReadPost,BufNewFile *.jl bot Tnew | T julia

