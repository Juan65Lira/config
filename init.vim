call plug#begin()
	Plug 'joshdick/onedark.vim'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'vim-airline/vim-airline'
	Plug 'preservim/nerdtree'
	Plug 'bfrg/vim-cpp-modern'
	Plug 'leafgarland/typescript-vim'
	Plug 'pangloss/vim-javascript'
	Plug 'lervag/vimtex'
call plug#end()

" colorscheme
syntax on
set termguicolors
colorscheme onedark

let g:airline_theme = 'onedark'

" misc
set number
set noexpandtab
set tabstop=3
set shiftwidth=3
set shiftround
set colorcolumn=100

set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300

set exrc
set secure
set nohlsearch

autocmd filetype python setlocal expandtab
autocmd InsertLeave * write

let g:tex_flavor = 'latex'

" bindings
nnoremap <c-j> ddp
inoremap <c-j> <esc>ddpi
nnoremap <c-k> ddkP
inoremap <c-k> <esc>ddkPi

nnoremap <a-j> yyp
inoremap <a-j> <esc>yypi
nnoremap <a-k> yyP
inoremap <a-k> <esc>yyPi

inoremap <c-d> <esc>ddi
nnoremap <c-u> viwU
inoremap <c-u> <esc>viwUea

nnoremap H ^
nnoremap L $
nnoremap J }
nnoremap K {

vnoremap H ^
vnoremap L $
vnoremap J }
vnoremap K {

nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

let mapleader = ";"

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

nnoremap <leader>w :write<cr>
nnoremap <leader>q :q<cr>

nnoremap <silent> <leader>t :below split<cr>
  \:resize 15<cr>
  \:set nonumber<cr>
  \:set signcolumn=no<cr>
  \:terminal<cr>i

nnoremap <leader>f :NERDTreeToggle<cr>

iabbrev adn and

" coc
let g:coc_global_extensions = [
	\ 'coc-spell-checker',
	\ 'coc-snippets',
	\ 'coc-actions',
	\ 'coc-pairs',
	\ 'coc-rls',
	\ 'coc-json',
	\ 'coc-calc',
	\ 'coc-cmake',
	\ 'coc-clangd',
	\ 'coc-vimtex',
	\ 'coc-tsserver',
	\ ]

if has("patch-8.1.1564")
	set signcolumn=number
else
	set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_end_enclosure() ? "<right>" :
			\ "<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_end_enclosure()
	let aux = getline('.')[col('.') - 1]
	return aux =~# '[>)}\]\"]' || aux == "'"
endfunction

if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
			\ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> <leader>[g <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>]g <Plug>(coc-diagnostic-next)

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

nmap <silent> <leader>rn <Plug>(coc-rename)

nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>

function s:show_documentation()
	if (index(['vim', 'help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:action_from_selection(type) abort
	execute 'CocCommand actions.open ' . a:type
endfunction

xnoremap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nnoremap <silent> <leader>a :<C-u>set operatorfunc=<SID>action_from_selection<CR>g@

" VERY IMPORTANT, DO NOT TOUCH!!!
if has('nvim')
	echom ">^.^<"
endif
