let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#wiki#define()
  return s:wiki
endfunction

let s:wiki = {
      \ 'name': 'wiki',
      \ 'sorters': 'sorter_word',
      \ 'default_action': 'open_focus',
      \}

function! s:wiki.gather_candidates(args, context)
  return map(globpath(wiki#get_root(), '**/*.wiki', 0, 1),
        \'{
        \ "word": substitute(fnamemodify(v:val, ":p:r"),
        \                    "^.*documents\/wiki\/", "", ""),
        \ "kind": "file",
        \ "action__path": v:val,
        \}')
endfunction

let s:open_focus = {}
function! s:open_focus.func(candidate) dict
  call unite#take_action('open', a:candidate)
  normal! zMzvzz
endfunction
call unite#custom_action('file', 'open_focus', s:open_focus)

let &cpo = s:save_cpo
unlet s:save_cpo
