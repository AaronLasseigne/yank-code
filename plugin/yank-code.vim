function! s:go(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  elseif a:0 > 1
    let [start_line, end_line] = [a:1, a:2]
  else
    let [start_line, end_line] = [line("'["), line("']")]
  endif

  let indent = 10000
  for line_num in range(start_line, end_line)
    let line = getline(line_num)
    if line !~ '^\s*$'
      let leading_spaces = matchend(line, '^ *')
      if leading_spaces < indent
        let indent = leading_spaces
      endif
    endif
  endfor

  let code = []
  if &commentstring =~ '%s'
    let line_note = ''
    if start_line == end_line
      let line_note = '(line '.start_line.')'
    else
      let line_note = '(lines '.start_line.'-'.end_line.')'
    endif
    let escaped_commentstring = substitute(&commentstring, '%\([^s]\|$\)', '%%\1', 'g')
    call add(code, printf(escaped_commentstring, @%.' '.line_note))
  endif

  let max_line_num_len = strlen(end_line)
  for line_num in range(start_line, end_line)
    let unindented_code = strcharpart(getline(line_num), indent)
    call add(code, unindented_code)
  endfor

  let @+ = join(code, "\n")."\n"
endfunction

command! -range -bar YankCode call s:go(<line1>, <line2>)
vnoremap <expr> <plug>YankCode <sid>go()
nnoremap <expr> <plug>YankCode <sid>go()
