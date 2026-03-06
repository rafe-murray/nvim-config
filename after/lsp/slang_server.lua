---@brief
---
--- https://github.com/hudson-trading/slang-server
---
--- A SystemVerilog language server based on the Slang library.
---
--- Refer to the [documentation](https://hudson-trading.github.io/slang-server/start/config/)

---@type vim.lsp.Config
return {
  cmd = { "slang-server" },
  root_markers = { ".git", ".slang" },
  filetypes = {
    "systemverilog",
    "verilog",
  },
}
