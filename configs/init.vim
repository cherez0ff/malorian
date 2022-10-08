"----------------------------------
" Common
"----------------------------------
"Reduce waitng for a key code sequence end
set timeoutlen=500
"Set background color (needed for colorscheme)
set background=dark
set termguicolors
"Turn backup off (no .swp, .un~, ~ files); Required by CoC plugin
set nobackup
set noswapfile
set nowritebackup
"Wrap lines
set wrap
"Enable mouse support
set mouse=a
"Enable system clipboard
set clipboard=unnamedplus
"Ignore case when searching
set ignorecase
"Hightlight search results
set hlsearch
"Highlight while typing a search command
set incsearch
"Highlight current line
set cursorline
"Enable line indexing
set number
set relativenumber
"Increase the undo limit
set history=100
"Use spaces instead of tabs
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
"Enables graphical menu of the matches in shell
set wildmenu
"Highlight 120th symbol
set colorcolumn=120
highlight ColorColumn ctermbg=darkgray
" Smart auto-indent
"set smartindent "UPD
"filetype indent off "UPD
filetype indent off
"UPD: disable parentheses highlight
let g:loaded_matchparen=1
"UPD attempt to show char code
set statusline=%b\ 0x%B " symbol code as digit and as hex
set statusline+=%= " Switch to the right side
set statusline+=%f\        "  Path to the file with space as separator
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

"Stop hightlighting of founded items by pressing Ctr+L
nnoremap <C-L> :nohlsearch<CR><C-L>

"Execute opened script/code by pressing F5 "UPD:-ated!
augroup rungroup
    autocmd!
    autocmd BufRead,BufNewFile *.go map <F5> :w <cr> :exec '!go run' shellescape(@%, 1)<cr>
    autocmd BufRead,BufNewFile *.sh map <F5> :w <cr> :exec '!bash' shellescape(@%, 1)  <cr>
    autocmd BufRead,BufNewFile *.c  map <F5> :w <cr> :exec '!gcc % -o %< && ./%<'      <cr>
    autocmd BufRead,BufNewFile *.py map <F5> :w <cr> :exec '!python' shellescape(@%, 1)<cr>
augroup END

syntax enable
colorscheme hybrid

call plug#begin()
Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

lua << EOF
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

require("indent_blankline").setup {
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    show_trailing_blankline_indent = false,
}
EOF

# Disable the fucking autoindent after inserting comments, OMG why is this shit even needed
autocmd BufNewFile,BufReadPost * if &filetype == "python" | set indentkeys-=0# | endif
autocmd BufNewFile,BufReadPost * if &filetype == "yaml" | set expandtab shiftwidth=2 indentkeys-=0# | endif

