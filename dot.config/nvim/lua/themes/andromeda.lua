-- Credits to original theme https://github.com/EliverLara/Andromeda
-- NvChad 2.5 base46 adaptation of the Andromeda VSCode theme
-- Full language support: HTML, CSS, JavaScript, TypeScript, Dart, Python, Bash, Lua, Go

local M = {}

M.base_30 = {
  white = "#D5CED9",
  darker_black = "#1B1D23",
  black = "#23262E", -- nvim bg
  black2 = "#20232A",
  one_bg = "#2e323d", -- real bg of onedark
  one_bg2 = "#333844",
  one_bg3 = "#3D4352",
  grey = "#746f77",
  grey_fg = "#A0A1A7", -- comments
  grey_fg2 = "#BAAFC0",
  light_grey = "#D5CED9",
  red = "#ee5d43",
  baby_pink = "#ff00aa",
  pink = "#f92672",
  line = "#333844", -- for lines like vertsplit
  green = "#96E072",
  vibrant_green = "#9BC53D",
  nord_blue = "#3B79C7",
  blue = "#7cb7ff",
  yellow = "#FFE66D",
  sun = "#FF9F2E",
  purple = "#c74ded",
  dark_purple = "#C668BA",
  teal = "#00e8c6",
  orange = "#f39c12",
  cyan = "#00e8c6",
  statusline_bg = "#20232A",
  lightbg = "#2e323d",
  pmenu_bg = "#00e8c6",
  folder_bg = "#7cb7ff",
  error = "#FC644D",
  warning = "#FF9F2E",
  info = "#00b0ff",
  hint = "#5BC0EB",
  -- Additional colors from VSCode theme
  focus_border = "#746f77",
  selection_bg = "#746f77",
  widget_shadow = "#14151A",
  button_bg = "#00e8c5",
  button_hover = "#07d4b6",
  input_bg = "#2b303b",
  input_border = "#363c49",
  diff_add = "#29BF12",
  diff_delete = "#F21B3F",
  diff_change = "#5BC0EB",
}

M.base_16 = {
  base00 = "#23262E", -- Default Background
  base01 = "#2e323d", -- Lighter Background (Status bar)
  base02 = "#333844", -- Selection Background
  base03 = "#746f77", -- Comments, Invisibles, Line Highlighting
  base04 = "#A0A1A7", -- Dark Foreground (Used for status bars)
  base05 = "#D5CED9", -- Default Foreground
  base06 = "#FFFFFF", -- Light Foreground
  base07 = "#FFFFFF", -- Light Background
  base08 = "#ee5d43", -- Red
  base09 = "#f39c12", -- Orange
  base0A = "#FFE66D", -- Yellow
  base0B = "#96E072", -- Green
  base0C = "#00e8c6", -- Cyan
  base0D = "#7cb7ff", -- Blue
  base0E = "#c74ded", -- Purple
  base0F = "#f92672", -- Hot Pink / Magenta
}

M.polish_hl = {
  treesitter = {
    -- Variables and identifiers
    ["@variable"] = { fg = M.base_16.base0C },
    ["@variable.builtin"] = { fg = M.base_16.base0F, italic = true },
    ["@variable.parameter"] = { fg = M.base_16.base09, italic = true },
    ["@variable.member"] = { fg = M.base_16.base0C },
    ["@property"] = { fg = M.base_16.base0C },
    ["@field"] = { fg = M.base_16.base0C },
    
    -- Numbers and literals
    ["@number"] = { fg = M.base_16.base09, bold = true },
    ["@number.float"] = { fg = M.base_16.base09 },
    ["@boolean"] = { fg = M.base_16.base08 },
    -- Better string highlighting
    ["@string"] = { fg = M.base_16.base0B },
    ["@string.escape"] = { fg = M.base_16.base0A, bold = true },
    ["@string.regexp"] = { fg = M.base_16.base0D },
    ["@character"] = { fg = M.base_16.base0B },
    ["@character.special"] = { fg = M.base_16.base0A },
    
    -- Types and classes
    ["@type"] = { fg = M.base_16.base0A },
    ["@type.builtin"] = { fg = M.base_16.base0A, bold = true },
    ["@type.qualifier"] = { fg = M.base_16.base0E, italic = true },
    ["@type.definition"] = { fg = M.base_16.base0A },
    ["@storageclass"] = { fg = M.base_16.base0E, italic = true },
    
    -- Functions and methods
    ["@function"] = { fg = M.base_16.base0A },
    ["@function.builtin"] = { fg = M.base_16.base0A, bold = true },
    ["@function.call"] = { fg = M.base_16.base0A },
    ["@function.macro"] = { fg = M.base_16.base0A },
    ["@method"] = { fg = M.base_16.base0A },
    ["@method.call"] = { fg = M.base_16.base0A },
    ["@constructor"] = { fg = M.base_16.base0A },
    
    -- Keywords and operators
    ["@keyword"] = { fg = M.base_16.base0E, italic = true },
    ["@keyword.function"] = { fg = M.base_16.base0E, italic = true },
    ["@keyword.operator"] = { fg = M.base_16.base08, italic = true },
    ["@keyword.return"] = { fg = M.base_16.base0E, italic = true },
    ["@keyword.import"] = { fg = M.base_16.base0E, italic = true },
    ["@keyword.export"] = { fg = M.base_16.base0E, italic = true },
    ["@keyword.conditional"] = { fg = M.base_16.base0E, italic = true },
    ["@keyword.repeat"] = { fg = M.base_16.base0E, italic = true },
    ["@keyword.storage"] = { fg = M.base_16.base0E, italic = true },
    ["@operator"] = { fg = M.base_16.base08 },
    
    -- Constants and enums
    ["@constant"] = { fg = M.base_16.base08, bold = true },
    ["@constant.builtin"] = { fg = M.base_16.base08 },
    ["@constant.macro"] = { fg = M.base_16.base08 },
    
    -- HTML/XML tags
    ["@tag"] = { fg = M.base_16.base0F },
    ["@tag.attribute"] = { fg = M.base_16.base09 },
    ["@tag.delimiter"] = { fg = M.base_16.base0F },
    
    -- Punctuation
    ["@punctuation.bracket"] = { fg = M.base_16.base04 }, -- slightly brighter brackets
    ["@punctuation.delimiter"] = { fg = M.base_16.base04 }, -- commas, semicolons
    ["@punctuation.special"] = { fg = M.base_16.base0A },
    
    -- Comments and documentation (EXCLUDED from base_16 change)
    ["@comment"] = { fg = M.base_30.grey_fg, italic = true },
    ["@comment.documentation"] = { fg = M.base_30.grey_fg2, italic = true },
    ["@text.todo"] = { fg = M.base_16.base0F, bold = true },
    ["@text.note"] = { fg = M.base_16.base0D, bold = true },
    ["@text.warning"] = { fg = M.base_16.base09, bold = true },
    ["@text.danger"] = { fg = M.base_16.base08, bold = true },
    
    -- Meta tags and annotations
    ["@attribute"] = { fg = M.base_16.base09, italic = true },
    ["@annotation"] = { fg = M.base_16.base09, italic = true },
    ["@decorator"] = { fg = M.base_16.base09, italic = true },
    
    -- Language-specific highlights
    -- JavaScript/TypeScript
    ["@constructor.javascript"] = { fg = M.base_16.base08 },
    ["@property.javascript"] = { fg = M.base_16.base0C },
    ["@tag.attribute.javascript"] = { fg = M.base_16.base0A, italic = true },
    ["@variable.builtin.javascript"] = { fg = M.base_16.base0C },
    ["@variable.parameter.javascript"] = { fg = M.base_16.base09, italic = true },
    ["@variable.parameter.typescript"] = { fg = M.base_16.base09, italic = true },
    ["@keyword.export.javascript"] = { fg = M.base_16.base0E, italic = true },
    ["@keyword.export.typescript"] = { fg = M.base_16.base0E, italic = true },
    ["@variable.builtin.typescript"] = { fg = M.base_16.base0F, italic = true },

    -- TSX
    ["@constructor.tsx"] = { fg = M.base_16.base08 },
    ["@property.tsx"] = { fg = M.base_16.base0A },
    ["@tag.attribute.tsx"] = { fg = M.base_16.base0A, italic = true },
    
    -- Python
    ["@attribute.python"] = { fg = M.base_16.base0A },
    ["@constant.python"] = { fg = M.base_16.base0C },
    ["@keyword.import.python"] = { fg = M.base_16.base0E, italic = true },
    ["@variable.parameter.python"] = { fg = M.base_16.base09, italic = true },
    ["@function.builtin.python"] = { fg = M.base_16.base0F, bold = true },
    ["@variable.builtin.python"] = { fg = M.base_16.base0F, italic = true },
    ["@constant.builtin.python"] = { fg = M.base_16.base08, bold = true },
    
    -- Go
    ["@keyword.package.go"] = { fg = M.base_16.base0E, italic = true },
    ["@type.builtin.go"] = { fg = M.base_16.base0A, bold = true },
    ["@function.builtin.go"] = { fg = M.base_16.base0F, bold = true },
    ["@variable.parameter.go"] = { fg = M.base_16.base09, italic = true },
    ["@keyword.import.go"] = { fg = M.base_16.base0E, italic = true },
    
    -- Dart
    ["@keyword.import.dart"] = { fg = M.base_16.base0E, italic = true },
    ["@type.builtin.dart"] = { fg = M.base_16.base0A, bold = true },
    ["@variable.parameter.dart"] = { fg = M.base_16.base09, italic = true },
    ["@function.builtin.dart"] = { fg = M.base_16.base0F, bold = true },
    ["@keyword.class.dart"] = { fg = M.base_16.base0E, italic = true },
    
    -- Enhanced Dart-specific highlighting
    ["@keyword.modifier.dart"] = { fg = M.base_16.base0E, italic = true }, -- for abstract, static, const, final
    ["@keyword.override.dart"] = { fg = M.base_16.base0C, italic = true, bold = true }, -- for @override annotation
    ["@annotation.dart"] = { fg = M.base_16.base0C, italic = true }, -- for all annotations
    ["@constructor.dart"] = { fg = M.base_16.base0D, bold = true }, -- for constructors
    ["@method.dart"] = { fg = M.base_16.base0A }, -- for methods
    ["@property.dart"] = { fg = M.base_16.base0C }, -- for getters/setters
    ["@keyword.control.dart"] = { fg = M.base_16.base08, italic = true }, -- for return, if, else
    ["@keyword.function.dart"] = { fg = M.base_16.base0E, italic = true }, -- for void, dynamic
    ["@string.interpolation.dart"] = { fg = M.base_16.base09 }, -- for string interpolation
    ["@variable.member.dart"] = { fg = M.base_16.base06 }, -- for class members like _name
    
    -- CSS
    ["@property.css"] = { fg = M.base_16.base0A },
    ["@punctuation.delimiter.css"] = { fg = M.base_16.base08 },
    ["@type.css"] = { fg = M.base_16.base0F },
    ["@string.css"] = { fg = M.base_16.base0B },
    ["@number.css"] = { fg = M.base_16.base09 },
    ["@keyword.css"] = { fg = M.base_16.base0E, italic = true },
    ["@function.css"] = { fg = M.base_16.base0A },
    
    -- HTML
    ["@tag.html"] = { fg = M.base_16.base0F },
    ["@tag.attribute.html"] = { fg = M.base_16.base0A },
    ["@tag.delimiter.html"] = { fg = M.base_16.base05 },
    ["@text.uri.html"] = { fg = M.base_16.base0B },
    ["@string.html"] = { fg = M.base_16.base0B },
    ["@text.html"] = { fg = M.base_16.base05 },
    
    -- Bash/Shell
    ["@variable.bash"] = { fg = M.base_16.base0C },
    ["@string.bash"] = { fg = M.base_16.base0B },
    ["@contstant.bash"] = { fg = M.base_16.base0C},
    ["@parameter.bash"] = { fg = M.base_16.base08},
    ["@function.bash"] = { fg = M.base_16.base0A },
    ["@keyword.bash"] = { fg = M.base_16.base0E, italic = true },
    ["@operator.bash"] = { fg = M.base_16.base08 },
    
    -- Lua
    ["@variable.lua"] = { fg = M.base_16.base0C },
    ["@string.lua"] = { fg = M.base_16.base0B },
    ["@function.lua"] = { fg = M.base_16.base0A },
    ["@keyword.lua"] = { fg = M.base_16.base0E, italic = true },
    ["@function.builtin.lua"] = { fg = M.base_16.base0F, bold = true },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "andromeda")

return M
