; extends
(member_expression
  object: (member_expression) @_env
  property: (property_identifier) @constant
  (#any-of? "import.meta.env" "process.env")
  (#lua-match? @constant "^_*[A-Z][A-Z%d_]*$"))
