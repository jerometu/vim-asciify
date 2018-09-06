"
" <This plugin generates ASCII art titles>
"
" Font: Small by Glenn Chappell 4/93 -- based on Standard 
" Quotes and other special characters not supported
"

command! -nargs=? -bar Asciify  call Transform(<f-args>)

function! Transform(...)
    try	
	let commentChar = "#"
	if a:0 != 0
	    let commentChar = a:1
	endif
        let font = '~/.vim/plugin/asciify/font.txt'
        let split = split(getline('.'),'\zs')
        let chars = []
        let i = 0
        while i < len(split)
            let char = system("line=$(sed -n \"/'". split[i] . "'/=\" ". font . "); sed $(expr $line + 1)', '$(expr $line + 5)'!d' ". font . ";")
            call add (chars, char)
            let i += 1
"                                _          _     _  _      
"                  ___  _ _   __| |__ __ __| |_  (_)| | ___ 
"                 / -_)| ' \ / _` |\ V  V /| ' \ | || |/ -_)
"                 \___||_||_|\__,_| \_/\_/ |_||_||_||_|\___|
"                                                           
        let p = 0
        while p < 5 
            let i = 0
	    let iniStr = commentChar . " " 
            let str = [iniStr]
            while i < len(chars)
                call add(str, split(chars[i],'\n')[p])
                let i += 1
            endwhile
            let str2 = substitute(join(str, ""), '\.', " ", "g")
            call append(line('.')-1, str2)
        let p += 1
        endwhile
        delete
    catch
	echo "Something went wrong. Some character are unsupported."
    endtry
endfunction
