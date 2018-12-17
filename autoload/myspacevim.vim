" Originally this file was downloaded from 
" https://git.mel.vin/conf/spacevim.d/raw/master/autoload/myspacevim.vim
"
func! myspacevim#before() abort
	" additional extensions for some filetypes
	autocmd BufRead,BufNewFile *.h setfiletype c
	autocmd BufRead,BufNewFile *.irst setfiletype rst
	autocmd BufRead,BufNewFile *.puml setfiletype plantuml
	autocmd BufRead,BufNewFile *.tikz setfiletype tex

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

  " tex_conceal
  let g:tex_conceal = "abs"

  " set textwidth
  set textwidth=78


endf

func! myspacevim#after() abort
	" disable the binding that hits ESC in insert mode
	iunmap jk

	" use tabs for rst
	autocmd Filetype rst setlocal noexpandtab

	" disable spell check for some filetypes
	autocmd Filetype diff,gitrebase,plantuml,yaml setlocal nospell


endf
