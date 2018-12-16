" Originally this file was downloaded from 
" https://git.mel.vin/conf/spacevim.d/raw/master/autoload/myspacevim.vim
"
func! Delete_trailing_spaces()
  exe "normal mz"
    %s/\s\+$//ge
  exe "normal `z"
endf

func! myspacevim#before() abort
	" delete trailing spaces on buffer write
	autocmd BufWrite * :call Delete_trailing_spaces()

	" highlight the first 3 characters over 80
	autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#501010
	autocmd BufEnter * match OverLength '\%<84v.\%>81v'

	" case insensitive search
	set ignorecase

	" render tab as triangle and space as a centred dot
	set list listchars=tab:▸\ ,trail:·

	" spell check British English
	set spell spelllang=en_gb

	" keep cursor in centre
	set so=999

	" format paragraph with 'gq' in normal mode
	" line wrap: default to 80 chars
	set tw=80
	" line wrap: recognise list alignment
	set fo+=n
	" line wrap: remove comment leader when joining lines
	set fo+=j

  " change directory on fly.
  set autochdir

	" vim-table-mode config
	" TODO make it language-specific feature for RST
	" with the , leader key from spacevim
	" custom layer?
	let g:table_mode_corner_corner='+'
	let g:table_mode_header_fillchar='='

	" additional extensions for some filetypes
	autocmd BufRead,BufNewFile *.h setfiletype c
	autocmd BufRead,BufNewFile *.irst setfiletype rst
	autocmd BufRead,BufNewFile *.puml setfiletype plantuml
	autocmd BufRead,BufNewFile *.tikz setfiletype tex

	" disable indentLine plugin, it changes conceal-related settings
	let g:indentLine_enabled=0

	" disable the chktex checker for tex, use only lacheck
	let g:neomake_tex_enabled_makers=['lacheck']

	" use clang-tidy for checking c/c++
	let g:neomake_c_enabled_makers=['clangtidy']
	let g:neomake_cpp_enabled_makers=['clangtidy']

	" vim-clang options
	let g:clang_compilation_database='.'
	let g:clang_verbose_pmenu=1

  set showcmd    " Show (partial) command in status line.
  set showmatch  " Show matching brackets.
  set smartcase  " Do smart case matching
  set incsearch  " Incremental search
  set mouse=v    " Enable mouse usage (all modes)
  set number
  set ruler
  set hlsearch
  set autoindent
  set smartindent
  set encoding=utf-8
  set fileencoding=utf-8
  syntax enable
  set complete-=k

  " Mappings
  source $HOME/.vim/mymappings.vim
  au BufNewFile *.snw read ~/Scripts/template.snw 
  au BufRead,BufNewFile *.nw set filetype=noweb
  au BufRead,BufNewFile *.cu set filetype=cpp
  au BufRead,BufNewFile *.scad set filetype=openscad
  au BufRead,BufNewFile *.snw set filetype=noweb
  au BufRead,BufNewFile *.w set filetype=noweb
  au BufRead,BufNewFile *.nw set spell spelllang=en
  au BufRead,BufNewFile *.blog set filetype=markdown
  au BufRead,BufNewFile *.labnote set filetype=tex
  au BufRead,BufNewFile *.csv set filetype=csv
  au BufRead,BufNewFile *.asy set filetype=cpp
  au BufRead,BufNewFile *.yacml set filetype=dot
  au BufRead,BufNewFile *.ino set filetype=cpp
  au BufRead,BufNewFile *.gnu,*.gnuplot,*.plt,*.gpi set filetype=gnuplot
  au BufRead,BufNewFile *.lyx set syntax=lyx foldmethod=syntax foldcolumn=3
  au BufRead,BufNewFile wscript set filetype=python 
  au BufRead *.lyx syntax sync fromstart
  au BufRead,BufNewFile *.jinja2,*.jinja,*.html set ft=jinja

  " Make pandoc behave like tex
  au BufRead,BufNewFile *.md setlocal filetype=pandoc |
      \ setlocal makeprg=md2pdf.sh\ % 

  au BufRead,BufNewFile *.pandoc setlocal filetype=pandoc
  au BufRead,BufNewFile *.pandoc setlocal spell spelllang=en
  let noweb_backend="tex"
  let noweb_language="haskell"
  let noweb_fold_code=1

  au BufRead,BufNewFile *.tex set spell spelllang=en
  au BufEnter *.tex set nosmartindent

  " Blog related setting.
  au BufRead,BufNew *.blog setlocal spell spelllang=en 
  au BufRead,BufNew *.blog setlocal complete+=k
  au BufRead,BufNew *.md setlocal complete+=k
  au BufRead,BufNew *.md setlocal spell spelllang=en
  au BufRead,BufNew *.markdown setlocal complete+=k
  au BufRead,BufNew *.markdown setlocal syntax=markdown
  au BufRead,BufNew *.markdown setlocal spell spelllang=en
  " On tmp files do not wrap lines by inserting newline, wrap it without newline.
  au BufRead,BufNew *.tmp setlocal wrap linebreak nolist 
  au BufRead,BufNew *.txt setlocal wrap linebreak nolist 


  au BufNewFile *.vhd read ~/.vim/template/template.vhd
  " au BufRead,BufNewFile *.bsv set filetype=verilog
  au BufRead,BufNewFile *.bsv set syntax=bsv
  au BufRead,BufNewFile *.max set filetype=maxima  nospell
  au BufRead,BufNewFile *.maxima set filetype=maxima nospell
  au BufRead,BufNewFile *.mac set filetype=maxima nospell
  au BufRead,BufNewFile *.maxima set filetype=maxima nospell
  au BufRead,BufNewFile *.mc set filetype=maxima nospell
  au BufRead,BufNewFile *.rules set filetype=make
  au BufRead,BufNewFile *.tex set filetype=tex

  " Python related settings
  autocmd BufRead *.py setlocal makeprg=pylint\ \ %:p
  let g:pymode_lint_write=0
  let g:pymode_lint=0

  ""indent guide
  "Bundle 'nathanaelkane/vim-indent-guides'
  "hi IndentGuidesOdd  ctermbg=white
  "hi IndentGuidesEven ctermbg=lightgrey
  "let g:indent_guides_enable_on_vim_startup = 1
  "let g:indent_guides_guide_size=1
  Bundle "Yggdroot/indentLine"
  let g:indentLine_char="⁞"

  " The very heavy plugin.
  " Bundle 'Valloric/YouCompleteMe'

  " default
  set softtabstop=4
  set shiftwidth=4
  set expandtab
  set smarttab
  set textwidth=80
  set wrap
  set iskeyword+=_
  set autoread
  set showmatch
  set errorbells
  set backspace=2 "
  " Create backup of all files.
  set backup
  set backupdir=~/vim-backup/,./.backup,/tmp,.
  set undofile

  let vimDir = '$HOME/.vim/'
  let myUndoDir=expand(vimDir . '/undodir')
  call system('mkdir -p ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile

  "" Read pdf file in vim
  command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
  command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78

  " clipboard
  set clipboard=unnamedplus

  """ When xlipboard support is not available
  :command -range Cz :silent :<line1>,<line2>w !xsel -i -b
  :command -range Cx :silent :<line1>,<line2>w !xsel -i -p
  :command -range Cv :silent :<line1>,<line2>w !xsel -i -s
  :cabbrev cv Cv
  :cabbrev cz Cz
  :cabbrev cx Cx

  :command -range Pz :silent :r !xsel -o -b
  :command -range Px :silent :r !xsel -o -p
  :command -range Pv :silent :r !xsel -o -s

  :cabbrev pz Pz
  :cabbrev px Px
  :cabbrev pv Pv

  augroup nonvim
     au!
     au BufRead *.png,*.jpg,*.pdf,*.gif,*.xls* sil exe "!open " . shellescape(expand("%:p")) | bd | let &ft=&ft
     au BufRead *.ppt*,*.doc*,*.rtf let g:output_pdf = shellescape(expand("%:r") . ".pdf")
     au BufRead *.ppt*,*.doc*,*.rtf sil exe "!/home/dilawar/Scripts/any2pdf " . shellescape(expand("%:p"))
     au BufRead *.ppt*,*.doc*,*.rtf sil exe "!open " . g:output_pdf | bd | let &ft=&ft
  augroup end

  " For mac
  set clipboard=unnamed
  " Diffdir options
  let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,*/.git/*"

  " wildcard
  set wildmode=longest,list,full
  set wildmenu
  set conceallevel=0

endf

func! myspacevim#after() abort
	" disable the binding that hits ESC in insert mode
	iunmap jk

	" use tabs for rst
	autocmd Filetype rst setlocal noexpandtab

	" disable spell check for some filetypes
	autocmd Filetype diff,gitrebase,plantuml,yaml setlocal nospell
endf
