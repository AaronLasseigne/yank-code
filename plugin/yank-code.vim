function! s:go(start_line, end_line) abort
  let indent = 10000
  for line_num in range(a:start_line, a:end_line)
    let line = getline(line_num)
    if line !~ '^\s*$'
      let leading_spaces = matchend(line, '^ *')
      if leading_spaces < indent
        let indent = leading_spaces
      endif
    endif
  endfor

  let code = []
  if a:start_line == a:end_line
    call add(code, printf(&commentstring, ' '.@%.' (line '.a:start_line.')'))
  else
    call add(code, printf(&commentstring, ' '.@%.' (lines '.a:start_line.'-'.a:end_line.')'))
  endif

  let max_line_num_len = strlen(a:end_line)
  for line_num in range(a:start_line, a:end_line)
    let unindented_code = strcharpart(getline(line_num), indent)
    call add(code, unindented_code)
  endfor

  let @+ = join(code, "\n")."\n"
endfunction

command! -range -bar YankCode call s:go(<line1>, <line2>)
