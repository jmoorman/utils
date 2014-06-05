" GENERAL OPTIONS
behave xterm
set viminfo='20,\"500,%	" ' Maximum number of previously edited files for which
                        "   the marks are remembered.  
			" " Maximum number of lines saved for each register.
			" % When included, save and restore the buffer list.
                        "   If Vim is started with a file name argument, the
                        "   buffer list is not restored.  If Vim is started
                        "   without a file name argument, the buffer list is
                        "   restored from the viminfo file.  Buffers without a
                        "   file name and buffers for help files are not written
			"   to the viminfo file.
set history=500		" keep {number} lines of command line history

" TAB HANDLING, C program formatting:
set tabstop=4		" ts, number of spaces that a tab *in an input file* is
                        "   equivalent to.
set shiftwidth=4	" sw, number of spaces shifted left and right when
                        "   issuing << and >> commands
set smarttab            " a <Tab> in an indent inserts 'shiftwidth' spaces
set softtabstop=4       " number of spaces that a tab *pressed by the user*
                        "   is equivalent to
set shiftround          " round to 'shiftwidth' for "<<" and ">>"
set expandtab           " don't input tabs; replace with spaces. <local to
                        "   buffer>
set numberwidth=1       " distance between line number and start of line
highlight LineNr term=bold cterm=NONE ctermfg=Magenta
   \ ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

filetype on

" Remove trailing whitespace when saving a file "
autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e

autocmd FileType * set formatoptions=tcql
    \ nocindent comments&
" Formatoptions: 'q' allows formatting with "gq".  'r' automates the middle of
"    a comment.  'o' automates comment formatting with the 'o' or 'O'
"    commands.  'c' wrap comments.  'l' do not break lines in insert mode.
autocmd FileType c,cpp :set formatoptions=clqro
    \ cindent comments=s1:/*,mb:*,ex:*/,://
set autoindent          " automatically set the indent of a new line (local to
                        "   buffer)
set nosmartindent       " no clever autoindenting (local to buffer); let cindent
                        "   do it

" if filetype is recognized as c or cpp, these inform cindent
set cinoptions=:0,p0,t0
set cinwords=if,unless,else,while,until,do,for,switch,case
set cinkeys=0{,0},0),:,0#,!^F,o,O,e
                        " keys that trigger C-indenting in Insert mode
                        "   (local to buffer)

set wrap                " whether to wrap lines
" Make breaks more obvious
set showbreak=+++\ \  
" set number		" number lines
set nocompatible
set incsearch
set showmatch
set backspace=1

syntax on               " colorize

" VIM DISPLAY OPTIONS
set showmode		" show which mode (insert, replace, visual)
set ruler
set title
set showcmd		" show commands in status line when typing
set wildmenu	

" KEY MAPPINGS
"   depending on your terminal software, you may have to fiddle with a few
"   things to make it look right for you.  It works for me logged in through
"   SSH.

:map <F2> :set filetype=c<cr>i/**<cr> @author Jon Moorman <cr>/<cr><cr>#include <stdio.h><cr>#include <stdlib.h><cr>#include <unistd.h><cr>#include <math.h><cr><cr>int<cr>main(int argc, char *argv[])<cr>{<cr><cr>return EXIT_SUCCESS;<cr><bs>}<esc>kka<tab>

"  F6 Clears up formatting by doing the following:
"  Ensure UNIX formatting (no CR chars, NL after the last line).
"  Insert a tab at the end of the current line (to avoid errors in next
"      step).
"  Then replace all tabs with 4 spaces.  That is, "detab".
"  Then, remove any spaces at the end of lines (this corrects the inserted
"      tab).
"  Then, clean up some annoying highlights in the file.
"  Note: this detabbing should work for tabs at the beginning of the line, but
"      will probably be somewhat wrong for tabs later in the line, but
"      wherever they used to be, they'll now be gone.
:map <F6> mzA	<esc>:set fileformat=unix<cr>:set endofline<cr>:%s/	/    /g<cr>:%s/ *$//<cr>:nohlsearch<cr>i<esc>`z

:imap <F6> <esc>mzA	<esc>:set fileformat=unix<cr>:set endofline<cr>:%s/	/    /g<cr>:%s/ *$//<cr>:nohlsearch<cr>i<esc>`za

"  Useful for limiting lines to 100 columns.  Goes to column 100, then back to a
"      previous space, then changes that space to a newline.  "autoindent" from
"      above completes this trick.
:nmap <F7> 100|F s<cr><esc>
:nmap <S-F7> 100|F s<cr><tab><esc>

:nmap <C-N> :set invnumber<CR>
" ABBREVIATIONS
:ab cmain <cr>int<cr>main(int argc, char *argv[])<cr>{<cr>return 0;<cr><bs>}<cr><esc>kkO

" Shortcut to execute the file being edited.
:nmap <C-X> :!./%<CR>
