local map = vim.keymap.set
-- Window mappings
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
map("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
map("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
map("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Clear highlights on search with <ESC>
-- Extra <ESC> is so that insert mode still returns to normal mode
map({ "n", "i" }, "<ESC>", "<cmd>nohlsearch<CR><ESC>")

map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open lazy.nvim" })
map("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Open Mason" })

map("n", "<leader>n", function()
  local cppman = require("cppman")
  cppman.open_cppman_for(vim.fn.expand("<cword>"))
end, { desc = "Search CPPMan" })

map("n", "H", function()
  local count = vim.v.count1
  vim.cmd(count .. "bprevious")
end, { desc = "Prev Buffer" })
map("n", "L", function()
  local count = vim.v.count1
  vim.cmd(count .. "bnext")
end, { desc = "Next Buffer" })

map("n", "<leader>gx", function()
  local path = vim.fn.expand("<cfile>")
  vim.ui.open("https://github.com/" .. path)
end, { desc = "Open package in GitHub" })
