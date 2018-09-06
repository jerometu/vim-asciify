"
" <This plugin generates ASCII art titles>
"
" Font stolen from https://github.com/DevonBernard/ASCII-Art
" Quotes and other special characters not supported
"

command! -bar Asciify  call Transform()

function! Transform()
    let split = split(getline('.'),'\zs')
    let chars = []
    let i = 0
    while i < len(split)
        let char = system("line=$(sed -n \"/'". split[i] . "'/=\" ~/.vim/plugin/asciify/font.txt); sed $(expr $line + 1)', '$(expr $line + 7)'!d' ~/.vim/plugin/asciify/font.txt;")
        call add (chars, char)
        let i += 1
    endwhile
    let p = 0
    while p < 7 
        let i = 0
        let str = ['# ']
        while i < len(chars)
            call add(str, split(chars[i],'\n')[p])
            let i += 1
        endwhile
        let str2 = substitute(join(str, " "), '\.', " ", "g")
        call append(line('.')-1, str2)
    let p += 1
    endwhile
    delete
endfunction
