;; extends

(attribute
  (attribute_name) @_name
  (quoted_attribute_value 
    (attribute_value) @injection.content)
  (#any-of? @_name "content-style" "contentStyle")
  (#set! injection.language "css"))
