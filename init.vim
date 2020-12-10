call plug#begin()
	Plug 'joshdick/onedark.vim'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'vim-airline/vim-airline'
	Plug 'preservim/nerdtree'
	Plug 'sheerun/vim-polyglot'
	Plug 'lervag/vimtex'
	Plug 'skammer/vim-css-color'
	Plug 'enricobacis/vim-airline-clock'
	Plug 'ryanoasis/vim-devicons'
call plug#end()

" colorscheme
syntax on
set termguicolors
colorscheme onedark
let g:airline_theme='onedark'


" misc
set number
set numberwidth=2
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

set mouse=a
set encoding=UTF-8

set list
set listchars=tab:│\ ,trail:▓

let g:tex_flavor = 'latex'

" bindings
nnoremap <c-u> viwU
inoremap <c-u> <esc>viwUea

noremap q ;

noremap d h
noremap h j
noremap t k
noremap n l

noremap D ^
noremap H }
noremap T {
noremap N $

noremap j d
noremap s ;
noremap S :

" TODO: visualmode block movement and duplication
nnoremap <a-h> yyp
nnoremap <a-t> yyP

nnoremap <c-h> ddp
nnoremap <c-t> ddkP

nnoremap <c-a-d> <C-W><C-H>
nnoremap <c-a-h> <C-W><C-J>
nnoremap <c-a-t> <C-W><C-K>
nnoremap <c-a-n> <C-W><C-L>

inoremap ; ;<esc>:write<cr>

let mapleader = "s"

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>ex :vsplit .exrc<cr>
nnoremap <leader>sx :source .exrc<cr>

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

let g:NERDTreeMapOpenInTab = "\<TAB>"
let g:NERDTreeQuitOnOpen = 1

iabbrev adn and

function RustSettings()
	setlocal noexpandtab
	setlocal tabstop=3
	setlocal shiftwidth=3

	iabbrev byte i8
	iabbrev ubyte u8
	iabbrev short i16
	iabbrev ushort u16
	iabbrev int i32
	iabbrev uint u32
	iabbrev long i64

	iabbrev float f32
	iabbrev double f64
endfunction

autocmd FileType rust call RustSettings()


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
