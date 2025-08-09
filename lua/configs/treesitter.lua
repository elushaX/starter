-- Define color palette
local palette = {
  yellow     = "#E7EA9E",
  light_gray = "#BCBEC4",
  blue       = "#6D97CF",
  dark_gray  = "#6D6D6D",
  gray  = "#A6A8B3",
  teal       = "#58E8C6",
  purple     = "#C497DE",
  gold       = "#D3D774",
  comment = "#7A7E85",
  local_var = "#A6A8B3",
  operator = "#6D97CF",
  string = "#BD8B49",
  statement = "#6D97CF",
  constant = "#6D97CF"
}

-- Define highlight groups with shared colors
local colors = {
  { id = "@lsp.type.function.cpp",       val = { fg = palette.yellow } },
  { id = "@lsp.type.variable.cpp",      val = { fg = palette.local_var } },
  { id = "@lsp.type.parameter.cpp",     val = { fg = palette.light_gray } },
  { id = "@lsp.type.property.cpp",      val = { fg = palette.light_gray } },
  { id = "@lsp.type.typeParameter.cpp", val = { fg = palette.light_gray } },
  { id = "@lsp.type.namespace.cpp",     val = { fg = palette.blue } },
  { id = "@lsp.type.keyword.cpp",       val = { fg = palette.blue } },
  { id = "@lsp.type.class.cpp",         val = { fg = palette.teal } },
  { id = "@lsp.type.enum.cpp",          val = { fg = palette.teal } },
  { id = "@lsp.type.definition.cpp",    val = { fg = palette.teal } },
  { id = "@lsp.type.type.cpp",          val = { fg = palette.teal } },
  { id = "@lsp.type.enumMember.cpp",    val = { fg = palette.gold } },
  { id = "@lsp.type.label.cpp",         val = { fg = palette.dark_gray } },
  { id = "cInclude",                    val = { fg = palette.dark_gray } },
  { id = "cDefine",                     val = { fg = palette.dark_gray } },
  { id = "cBlock",                      val = { fg = palette.blue } },
  { id = "cppStatement",                val = { fg = palette.blue } },
  { id = "cTypedef",                    val = { fg = palette.blue } },
  { id = "cppStructure",                val = { fg = palette.blue } },
  { id = "cStructure",                  val = { fg = palette.blue } },
  { id = "cType",                       val = { fg = palette.blue } },
  { id = "cStorageClass",               val = { fg = palette.blue } },
  { id = "Macro",                       val = { fg = palette.purple } },
  
  { id = "cPreCondit",                       val = { fg = palette.dark_gray } },
  { id = "cPreProc",                       val = { fg = palette.dark_gray } },
  { id = "PreProc",                       val = { fg = palette.dark_gray } },

  { id = "cPreConditMatch",                       val = { fg = palette.dark_gray } },
  { id = "@lsp.type.macro.cpp",                       val = { fg = palette.purple } },
   { id = "cComment",                       val = { fg = palette.comment } },
    { id = "Comment",                       val = { fg = palette.comment } },
     { id = "cCommentL",                       val = { fg = palette.comment } },
     { id = "@lsp.type.operator.cpp",                       val = { fg = palette.operator } },
{ id = "String",                       val = { fg = palette.string } },
{ id = "Statement",                       val = { fg = palette.statement } },
{ id = "cppConstant",                       val = { fg = palette.constant } },
{ id = "Constant",                       val = { fg = palette.constant } },

{ id = "cConditional",                       val = { fg = palette.blue } },
{ id = "Conditional",                       val = { fg = palette.blue } },
{ id = "cRepeat",                       val = { fg = palette.blue } },
{ id = "Repeat",                       val = { fg = palette.blue } },
{ id = "cOperator",                       val = { fg = palette.blue } },
{ id = "Operator",                       val = { fg = palette.blue } },
{ id = "cppModifier",                       val = { fg = palette.blue } },
{ id = "Type",                       val = { fg = palette.blue } },
{ id = "cLabel",                       val = { fg = palette.blue } },
{ id = "Label",                       val = { fg = palette.blue } },
{ id = "cppExceptions",                       val = { fg = palette.blue } },
{ id = "Exceptions",                       val = { fg = palette.blue } },
{ id = "cppStorageClass",                       val = { fg = palette.blue } },
{ id = "StorageClass",                       val = { fg = palette.blue } },

{ id = "cSpecial",                       val = { fg = palette.gray } },
{ id = "SpecialChar",                       val = { fg = palette.gray } },

{ id = "cBracket",                       val = { fg = palette.gray } },
{ id = "cppRawStringDelimiter",                       val = { fg = palette.gray } },
{ id = "Delimiter",                       val = { fg = palette.gray } },
{ id = "cParen",                       val = { fg = palette.gray } },
}

-- Apply highlights
for _, color in ipairs(colors) do
  vim.api.nvim_set_hl(0, color.id, color.val)
end