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
let g:gruvbox_material_palette = 'material'
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_diagnostic_text_highlight = 1
let g:gruvbox_material_better_performance = 1
" let g:gruvbox_material_palette = {
"       \ 'bg0':              ['#1d2021',   '234'],
"       \ 'bg1':              ['#282828',   '235'],
"       \ 'bg2':              ['#282828',   '235'],
"       \ 'bg3':              ['#3c3836',   '237'],
"       \ 'bg4':              ['#3c3836',   '237'],
"       \ 'bg5':              ['#504945',   '239'],
"       \ 'bg_statusline1':   ['#282828',   '235'],
"       \ 'bg_statusline2':   ['#32302f',   '235'],
"       \ 'bg_statusline3':   ['#504945',   '239'],
"       \ 'bg_diff_green':    ['#32361a',   '22'],
"       \ 'bg_visual_green':  ['#333e34',   '22'],
"       \ 'bg_diff_red':      ['#3c1f1e',   '52'],
"       \ 'bg_visual_red':    ['#442e2d',   '52'],
"       \ 'bg_diff_blue':     ['#0d3138',   '17'],
"       \ 'bg_visual_blue':   ['#2e3b3b',   '17'],
"       \ 'bg_visual_yellow': ['#473c29',   '94'],
"       \ 'bg_current_word':  ['#32302f',   '236'],
"       \ 'fg0':              ['#d8caac',   '223'],
"       \ 'fg1':              ['#e0d2b3',   '223'],
"       \ 'red':              ['#e68183',   '167'],
"       \ 'orange':           ['#e39b7b',   '208'],
"       \ 'yellow':           ['#d9bb80',   '214'],
"       \ 'green':            ['#a7c080',   '142'],
"       \ 'aqua':             ['#87c095',   '108'],
"       \ 'blue':             ['#83b6af',   '109'],
"       \ 'purple':           ['#d39bb6',   '175'],
"       \ 'bg_red':           ['#ea6962',   '167'],
"       \ 'bg_green':         ['#a9b665',   '142'],
"       \ 'bg_yellow':        ['#d8a657',   '214'],
"       \ 'grey0':            ['#7c6f64',   '243'],
"       \ 'grey1':            ['#928374',   '245'],
"       \ 'grey2':            ['#a89984',   '246'],
"       \ 'none':             ['NONE',      'NONE']
"       \ }

let g:miramare_enable_italic = 1
let g:miramare_enable_italic_string = 1
let g:miramare_palette = {'green':['#a7c080', '142', 'Green']}

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
nnoremap <silent> <Leader>tf :Files<CR>
nnoremap <silent> <Leader>tF :Files ~<CR>
nnoremap <silent> <Leader>tg :GFiles<CR>
nnoremap <silent> <Leader>tb :Buffers<CR>
nnoremap <silent> <Leader>ti :BLines<CR>
nnoremap <silent> <Leader>tI :Lines<CR>
nnoremap <silent> <Leader>tm :History:<CR>
nnoremap <silent> <Leader>tM :History<CR>
nnoremap <silent> <Leader>tc :Commands<CR>
nnoremap <silent> <Leader>tt :Helptags<CR>
nnoremap <silent> <Leader>ts :Colors<CR>
" }}}
" {{{ telescope
nnoremap <silent> <Leader>to :Telescope builtin<CR>
" }}}
" {{{ indentline
let g:indentLine_char='|'
let g:indentLine_color_gui='#404040'
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
" " {{{ coc
" nmap <silent> [d <Plug>(coc-diagnostic-prev)
" nmap <silent> ]d <Plug>(coc-diagnostic-next)

" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" nnoremap <silent> K :call <SID>show_documentation()<CR>

" nmap <silent> <Leader>rn <Plug>(coc-rename)
" xmap <silent> <Leader>rn <Plug>(coc-rename)

" nmap <silent> <Leader>cf <Plug>(coc-format-selected)
" xmap <silent> <Leader>cf <Plug>(coc-format-selected)

" nmap <silent> <Leader>ca <Plug>(coc-codeaction-selected)
" xmap <silent> <Leader>ca <Plug>(coc-codeaction-selected)

" nmap <silent> <Leader>cac <Plug>(coc-fix-current)
" nmap <silent> <Leader>cqf <Plug>(coc-fix-current)

" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
" inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" nmap <silent> <Leader>c<Space> :CocList<CR>
" nnoremap <silent><nowait> <space>J  :<C-u>CocNext<CR>
" nnoremap <silent><nowait> <space>K  :<C-u>CocPrev<CR>
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" " }}}
" {{{ git
nmap <silent> <Leader>gg <Plug>(git-messenger)
nmap <silent> <Leader>ga :Gwrite<CR>
nmap <silent> <Leader>gb :Gblame<CR>
nmap <silent> <Leader>gc :Git commit<CR>
nmap <silent> <Leader>gd :Gvdiffsplit<CR>
nmap <silent> <Leader>gf :Gfetch<CR>
nmap <silent> <Leader>gm :Git push<CR>
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
nnoremap <silent> <Leader>Q :q!<CR>
nnoremap <silent> <Leader>x :x<CR>
nnoremap <silent> <Leader>s :w<CR>
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" }}}
" {{{ comletion-nvim
autocmd BufEnter * lua require'completion'.on_attach()

let g:completion_chain_complete_list = [
  \{'complete_items': [ 'path', 'buffers' ]},
  \{'mode': '<c-p>'},
  \{'mode': '<c-n>'}
\]

let g:completion_auto_change_source = 1

set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
" set shortmess+=c
"}}}
" " {{{ treesitter
" " set foldmethod=expr
" " set foldexpr=nvim_treesitter#foldexpr()

" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   highlight = {
"     enable = true,
"   },
"   incremental_selection = {
"     enable = true,
"     keymaps = {
"       init_selection = "gnn",
"       node_incremental = "grn",
"       scope_incremental = "grc",
"       node_decremental = "grm",
"     },
"   },
"   indent = {
"     enable = true
"   },
" }
" EOF
" " }}}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
