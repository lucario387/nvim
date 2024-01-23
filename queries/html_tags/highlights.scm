;; extends
(attribute
  (attribute_name) @_att_name
  (#eq? @_att_name "class")
  (quoted_attribute_value
    (attribute_value) @conceal @madge
    (#set! @conceal conceal "…")))
