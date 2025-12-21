return {
  terminal_colors = true,
  undercurl = false,
  underline = true,
  bold = true,

  italic = {
    strings = false,
    emphasis = false,
    comments = false,
    operators = false,
    folds = false,
  },

  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,

  inverse = true,
  contrast = "",

  palette_overrides = {},

  overrides = {
    ["@variable"] = { link = "Normal" },
    ["@field"] = { link = "Normal" },
    ["@property"] = { link = "Normal" },
    ["@parameter"] = { link = "Normal" },
    ["@constant"] = { link = "Normal" },
    ["@type"] = { link = "Type" },
    ["@function"] = { link = "Function" },
  },

  dim_inactive = false,
  transparent_mode = false,
}
