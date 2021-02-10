set langmap=hjklmneiHJKLMNEI;mneihjklMNEIHJKL

set scrolloff=15
set sidescrolloff=40

set smartindent expandtab
set softtabstop=2 shiftwidth=2
set number relativenumber
set ignorecase smartcase

set clipboard=unnamedplus

set inccommand=nosplit
set showmatch matchtime=2

set cursorline
set colorcolumn=80

set foldmethod=marker

set noshowmode
set nojoinspaces
set fillchars=fold:\ ,

set linebreak
set breakindent
set showbreak=++

set signcolumn=yes
set splitright splitbelow
set hidden
set pumheight=15
set shortmess+=a
set lazyredraw

set history=256
set undofile

let mapleader="\<Space>"

"{{{ Filetypes
filetype indent plugin on
" }}}
" {{{ rainbow
let g:rainbow_active = 1
" }}}
" {{{ colorscheme
if has('termguicolors')
  set termguicolors
endif

let g:gruvbox_material_background = 'hard'

let g:gruvbox_material_palette = 'original'
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1

let g:miramare_enable_italic = 1
colorscheme miramare
" }}}
" {{{ buffers
nnoremap <silent> <Tab> :b#<CR>
nnoremap <silent> <Leader>j :bnext<CR>
nnoremap <silent> <Leader>k :bprevious<CR>
nnoremap <silent> <Leader>d :bdelete<CR>
nnoremap <silent> <Leader>D :bdelete!<CR>
" }}}
" {{{ windows
nnoremap <Leader>w <C-W>
nmap <silent> <Leader>wn :vnew<CR>
nmap <silent> <Leader>wN :new<CR>
nmap <silent> <Leader>wq :close<CR>
nmap <silent> <Leader>wQ :close!<CR>
nmap <silent> <Leader>wp :vsplit #<CR>
nnoremap <Leader>w< :vertical resize<Space>
nnoremap <Leader>w> :resize<Space>
" }}}
" {{{ netrw
let g:netrw_browse_split=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_banner=0
nmap <silent> <Leader>f :Lexplore!<CR>
autocmd FileType netrw setl bufhidden=wipe
" }}}
" {{{ sneak
let g:sneak#label=1
let g:sneak#target_labels="ntesir"
highlight! SneakLabelMask guifg=#e6d6ac guibg=#e6d6ac
" }}}
" {{{ undotree
let g:undotree_SetFocusWhenToggle=1
let g:undotree_HelpLine=0
let g:undotree_WindowLayout=3
let g:undotree_ShortIndicators=1
nnoremap <silent> <Leader>u :UndotreeToggle<CR>
" }}}
" {{{ fzf
let g:fzf_layout = { 'down': '~25%' }
nnoremap <silent> <Leader>tf :Files %:p:h<CR>
nnoremap <silent> <Leader>tF :Files ~<CR>
nnoremap <silent> <Leader>tg :cd %:p:h <bar> GFiles<CR>
nnoremap <silent> <Leader>tb :Buffers<CR>
nnoremap <silent> <Leader>ti :BLines<CR>
nnoremap <silent> <Leader>tI :Lines<CR>
nnoremap <silent> <Leader>tm :History:<CR>
nnoremap <silent> <Leader>tM :History<CR>
nnoremap <silent> <Leader>tc :Commands<CR>
nnoremap <silent> <Leader>tt :Helptags<CR>
nnoremap <silent> <Leader>ts :Colors<CR>
" }}}
" {{{ indentline
let g:indentLine_char='|'
let g:indentLine_color_gui='#444444'
" }}}
" {{{ better whitespace
let g:better_whitespace_guicolor='#444444'
let g:strip_whitespace_on_save=1
let g:strip_max_file_size=0
let g:show_spaces_that_precede_tabs=1
" }}}
" {{{ airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
" }}}
" {{{ coc
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <silent> <Leader>rn <Plug>(coc-rename)
xmap <silent> <Leader>rn <Plug>(coc-rename)

nmap <silent> <Leader>cf <Plug>(coc-format-selected)
xmap <silent> <Leader>cf <Plug>(coc-format-selected)

nmap <silent> <Leader>ca <Plug>(coc-codeaction-selected)
xmap <silent> <Leader>ca <Plug>(coc-codeaction-selected)

nmap <silent> <Leader>cac <Plug>(coc-fix-current)
nmap <silent> <Leader>cqf <Plug>(coc-fix-current)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

nmap <silent> <Leader>c<Space> :CocList<CR>
nnoremap <silent><nowait> <space>J  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>K  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}
" {{{ git
nmap <silent> <Leader>gg <Plug>(git-messenger)
nmap <silent> <Leader>ga :Gwrite<CR>
nmap <silent> <Leader>gb :Gblame<CR>
nmap <silent> <Leader>gc :Git commit<CR>
nmap <silent> <Leader>gd :Gvdiffsplit<CR>
nmap <silent> <Leader>gf :Gfetch<CR>
nmap <silent> <Leader>gh :Gpush<CR>
nmap <silent> <Leader>gp :Git pull --ff-only<CR>
nmap <silent> <Leader>gs :Git<CR>
nmap <silent> <Leader>gu :Gread<CR>
" }}}
" {{{ keybindings
noremap <Space> <Nop>
map <silent> Q <Nop>
nnoremap <CR> <Nop>
nmap j gj
nmap k gk
vmap j gj
vmap k gk
noremap , za
nnoremap H ^
nnoremap L $
nnoremap U <C-r>
vnoremap v <Esc>
nnoremap <silent> Y y$
nnoremap <silent> <Leader>/ :nohlsearch<CR>
vnoremap > >gv
vnoremap < <gv

nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>x :x<CR>
nnoremap <silent> <Leader>s :w<CR>
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" }}}
