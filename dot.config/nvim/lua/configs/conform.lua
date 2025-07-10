local options = {
  formatters_by_ft = {
    -- Lua
    lua = { "stylua" },
    
    -- Web technologies
    html = { "prettier" },
    css = { "prettier" },
    javascript = { "prettier", "eslint_d" },
    typescript = { "prettier", "eslint_d" },
    
    -- Python
    python = { "black", "isort" },
    
    -- Go
    go = { "gofumpt", "goimports" },
    
    -- Dart
    dart = { "dart_format" },
  },

  -- Enable format on save
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
