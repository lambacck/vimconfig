"make .inc files be Makefile includes
if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.inc    setfiletype make
    au! BufRead,BufNewFile *.vssl    setfiletype vssl
    au! BufRead,BufNewFile kermit_*.txt    setfiletype twikiSyntax
    au! BufRead,BufNewFile *.mak    setfiletype mako
    au! BufRead,BufNewFile *_setup_page_edit.aspPageHelp*.txt   setfiletype html
    au! BufRead,BufNewFile *.aspx setfiletype aspxcs
augroup END
