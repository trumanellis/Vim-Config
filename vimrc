source ~/.vim/bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" Source the vimrc file after saving it
" if has("autocmd")
"   autocmd bufwritepost .vimrc source $MYVIMRC
" endif

set nocompatible

syntax on
filetype plugin indent on
set nowrap
set hlsearch 
set incsearch
set nospell

" Remap hjkl to jkl;
" noremap ; l
" noremap l k
" noremap k j
" noremap j h

set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

" Colorscheme
set t_Co=256
colorscheme wombat256mod 

" Set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}

" GVim settings
set guioptions-=m
set mouse=c
" Hide GVim menu
set guioptions-=T

" Search settings
nnoremap <space> :noh<return><space>

" Change repeat command to set cursor to before change
nmap . .`[

" Indent Settings
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

" Movement settings
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <Left> <c-w>h
map <Right> <c-w>l
map <Up> <c-w>k
map <Down> <c-w>j

" Comment Settings
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Paste settings
nnoremap <F12> :set invpaste paste?<CR>
set pastetoggle=<F12>
set showmode
set textwidth=78

" FSwitch settings
let b:fsnonewfiles = 'on'
augroup mycppfiles
  au!
  au BufEnter *.h let b:fswitchdst  = 'cpp'
  " au BufEnter *.hpp let b:fswitchdst  = 'cpp'
  " au BufEnter *.h let b:fswitchlocs = '../src/.*/'
  au BufEnter *.hpp let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/,./'
augroup END
augroup myheaderfiles
  au!
  au BufEnter *.cpp let b:fswitchdst  = 'h'
  " au BufEnter *.cpp let b:fswitchlocs = '../../include'
  au BufEnter *.cpp let b:fswitchlocs = 'src/include,reg:/src/include/,reg:/src.*/include/,./'
augroup END
command! A :FSHere
command! Al :FSRight
command! AL :FSSplitRight
command! Ah :FSLeft
command! AH :FSSplitLeft
command! Ak :FSAbove
command! AK :FSSplitAbove
command! Aj :FSBelow
command! AJ :FSSplitBelow

" Buffer settings
set hidden
set wildchar=<Tab> wildmenu wildmode=full

"Vim-LaTeX Settings
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let g:Tex_CompileRule_dvi = 'latex -src-specials -interaction=nonstopmode $*'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_GotoError=1
let g:Tex_ViewRule_pdf = 'evince'
let g:Tex_MultipleCompileFormats = 'pdf'

" Abbreviations
ab pymain if __name__=="__main__":
ab teh the

" Ctag settings
set tags+=./tags
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/trilinos
set tags+=~/.vim/tags/camellia
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" set complete-=i

" Omnicomplete settings
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp,*.h,*.C,*.cxx set omnifunc=omni#cpp#complete#Main
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
nnoremap TT :TlistToggle<CR>
map <F4> :TlistToggle<CR>
" Various Taglist diplay config:
let Tlist_Use_Right_Window = 1
" let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Show_One_File = 1

" Tags search
set tags+=tags;$HOME

" NERDTree settings
let NERDTreeIgnore=['\.o$', '\~$']

" GNU indent style    
function! GnuIndent()
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=2
  setlocal tabstop=8
endfunction
au FileType C,h call GnuIndent() 

" Scons settings
autocmd BufReadPre SConstruct set filetype=python
autocmd BufReadPre SConscript set filetype=python

" Read vtu files as xml
au BufRead,BufNewFile *.vtu set filetype=xml
