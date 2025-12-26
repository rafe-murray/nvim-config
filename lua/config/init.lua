-- Load the colorscheme
require("tokyonight").load()

-- Language servers
vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")

vim.g.have_nerd_font = true

-- Show signs so that when they are added (e.g. by an lsp) columns are not shifted
vim.g.signcolumn = "yes"

-- Where to split
vim.o.splitbelow = true
vim.o.splitright = true

-- Grep options; these are set by default when ripgrep is installed but are also
-- set explicitly here
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep -uu"
-- Uncomment for wrapped text
-- vim.g.breakindent = true
-- vim.g.wrap = true

-- Tabs
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Hide mode since it is already shown in lualine
vim.o.showmode = false

-- Use system clipboard
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

local severityIcons = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.HINT] = " ",
  [vim.diagnostic.severity.INFO] = " ",
}

-- Show diagnostics
vim.diagnostic.config({
  virtual_text = {
    current_line = true,
    prefix = "●",
  },
  signs = {
    text = severityIcons,
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
    },
  },
  severity_sort = true,
})
vim.o.cursorline = false
vim.opt.guicursor = ""
vim.o.ignorecase = true
vim.o.smartcase = true
-- Decrease update time for swap file
vim.o.updatetime = 250
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
-- Load all other config files
require("config/keymaps")
require("config/fold")

local default_on_attach = vim.lsp.config["clangd"].on_attach or {}
vim.lsp.config("clangd", {
  on_attach = function(client, bufnr)
    default_on_attach(client, bufnr)
    vim.keymap.set("n", "<leader>h", function()
      vim.cmd("LspClangdSwitchSourceHeader")
    end, { desc = "Switch source and header (Clangd)" })
  end,
})
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = { ["/Users/rafe/.hammerspoon/Spoons/EmmyLua.spoon/annotations"] = true },
      },
    },
  },
})
vim.lsp.config("pyright", {
  root_markers = {
    "pyrightconfig.json",
    ".git",
  },
})

-- Add autocmd to remove everything that takes up the left margin on man pages
vim.api.nvim_create_autocmd("FileType", {
  pattern = "man",
  callback = function()
    vim.opt_local.signcolumn = "no"
    vim.o.number = false
    vim.o.relativenumber = false
    vim.o.foldcolumn = "0"
  end,
})
