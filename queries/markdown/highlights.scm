;; extends

(pipe_table_header
  [
    (pipe_table_cell)
  ] @text.header
)

; ( (fenced_code_block_delimiter) @conceal (#set! conceal "~"))

((task_list_marker_checked) @conceal.checked
  (#set! conceal " "))

((task_list_marker_unchecked) @conceal.unchecked
  (#set! conceal " "))
