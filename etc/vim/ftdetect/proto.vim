" Map protocol buffer files to the correct filetype
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end
