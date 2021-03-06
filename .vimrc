" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

syntax on  
syntax enable  
filetype on
filetype indent on                 
filetype plugin on  
filetype plugin indent on  
  
set mat=2  
set so=7  
set tm=500  
set t_vb=  
set nowb  
set paste  
set magic         
set number  
set showcmd  
set mouse-=a 
set wildmenu  
set nobackup
set gdefault
set autoread
set hlsearch
set incsearch
set showmatch  
set smartcase  
set ignorecase
set noswapfile
set cursorline    
set matchtime=1
set noerrorbells  
set novisualbell  
set tabstop=4 
set shiftwidth=4  
set expandtab 
set softtabstop=4  
set laststatus=2
set cmdheight=1
set history=1000         
set nocompatible        
set shortmess=atI       
set selection=exclusive    
set selectmode=mouse,key  
set ffs=unix,dos,mac  
set formatoptions+=m  
set formatoptions+=B  
set bs=indent,eol,start		
set viminfo='20,\"120	"read/write a .viminfo file, don't store more than 120 lines of registers
set whichwrap+=<,>,h,l  
set wildignore=*.o,*~,*.pyc  
set completeopt=longest,menu  
set backspace=eol,start,indent  
set fileencodings=ucs-bom,utf-8,gb18030,default  
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
  
autocmd InsertLeave * se nocul  
autocmd InsertEnter * se cul    
autocmd! bufwritepost .vimrc source % 
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab  
autocmd FileType python set omnifunc=pythoncomplete#Complete  
" Return to last edit position when opening files (You want this!)  
autocmd BufReadPost *  
     \ if line("'\"") > 0 && line("'\"") <= line("$") |  
     \   exe "normal! g`\"" |  
     \ endif  
  
"pydiction 1.2 python auto complete  
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'  
"defalut g:pydiction_menu_height == 15  
let g:pydiction_menu_height = 20   

nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>  

if &term=="xterm" || &term=="xterm-256-color" || &term=="xterm-termite"
     set t_Co=256
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

colorscheme molokai

"set t_Co=16  
"set background=light  
"set background=dark  
"let g:solarized_termcolors=16
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"colorscheme solarized

if &term=="xterm-termite"
    highlight Normal ctermbg=None
    highlight NonText ctermbg=None
endif
