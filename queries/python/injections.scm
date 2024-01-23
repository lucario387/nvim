; extend

; (
;   assignment
;     left: (_)
;     right: (string) @regex
;   #lua-match? @regex "^r'.*" 
; )

; (argument_list
;   (string
;     (string_content) @injection.content)
;   (#lua-match? @injection.content "^SELECT")
;   (#set! injection.language "sql"))
