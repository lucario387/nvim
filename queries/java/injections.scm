;; extends

; (
;   method_invocation
;     name: (identifier) @_method
;     arguments: 
;       (argument_list . [ (string_literal) (text_block) ] @injection.content (#set! injection.language "printf"))
;   (#any-of? @_method "format" "printf")
; )

(annotation
  (identifier) @_name
  (annotation_argument_list
    (string_literal
      [ 
        (string_fragment)
        (multiline_string_fragment)
      ] @injection.content))
  (#eq? @_name "Query")
  (#set! injection.language "sql"))
