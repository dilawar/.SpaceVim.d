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

  " leader key
  " let mapleader="\\"
endf

func! myspacevim#after() abort
	" disable the binding that hits ESC in insert mode
	iunmap jk

	" use tabs for rst
	autocmd Filetype rst setlocal noexpandtab

	" disable spell check for some filetypes
	autocmd Filetype diff,gitrebase,plantuml,yaml setlocal nospell
endf
