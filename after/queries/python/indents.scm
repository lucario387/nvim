; extends

; (return_statement
;   [
;     (_) @indent_end 
;     (_ (_) @indent_end .)
;     (attribute 
;       attribute: (_) @indent_end)
;     "return" @indent_end
;   ] .)

((match_statement) @indent
 (#set! "immediate_indent" 1))

((case_clause) @indent
 (#set! "immediate_indent" 1))

