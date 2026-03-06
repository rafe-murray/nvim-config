-- local gitsigns = require("gitsigns")
local builtin = require("telescope.builtin")

---@alias Mode "n"|"i"|"x"|"v"|"s"|"o"|"l"|"c"|"t"

---@class Key
---@field mode Mode|Mode[]
---@field lhs string
---@field rhs string|function
---@field desc string

---@class Keymaps
---@field keys Key[]
---@field gitsigns fun(): Key[]
---@field telescope Key[]
---@field markdownPreview Key[]
---@field trouble Key[]
---@field todoCommends Key[]
---@field lsp Key[]
---@field flutter Key[]
local M = {
  keys = {
    -- Window mappings
    {
      mode = "n",
      lhs = "<C-h>",
      rhs = "<C-w><C-h>",
      desc = "Move focus to the left window",
    },
    {
      mode = "n",
      lhs = "<C-l>",
      rhs = "<C-w><C-l>",
      desc = "Move focus to the right window",
    },
    {
      mode = "n",
      lhs = "<C-j>",
      rhs = "<C-w><C-j>",
      desc = "Move focus to the lower window",
    },
    {
      mode = "n",
      lhs = "<C-k>",
      rhs = "<C-w><C-k>",
      desc = "Move focus to the upper window",
    },

    {
      mode = "n",
      lhs = "<C-S-h>",
      rhs = "<C-w>H",
      desc = "Move window to the left",
    },
    {
      mode = "n",
      lhs = "<C-S-l>",
      rhs = "<C-w>L",
      desc = "Move window to the right",
    },
    {
      mode = "n",
      lhs = "<C-S-j>",
      rhs = "<C-w>J",
      desc = "Move window to the lower",
    },
    {
      mode = "n",
      lhs = "<C-S-k>",
      rhs = "<C-w>K",
      desc = "Move window to the upper",
    },
    -- Clear highlights on search with <ESC>
    -- Extra <ESC> is so that insert mode still returns to normal mode
    { mode = { "n", "i" }, lhs = "<ESC>", rhs = "<cmd>nohlsearch<CR><ESC>", desc = "Remove search highlight" },

    {
      mode = "n",
      lhs = "<leader>l",
      rhs = "<cmd>Lazy<CR>",
      desc = "Open lazy.nvim",
    },
    {
      mode = "n",
      lhs = "<leader>m",
      rhs = "<cmd>Mason<CR>",
      desc = "Open Mason",
    },

    {
      mode = "n",
      lhs = "<leader>n",
      rhs = function()
        local cppman = require("cppman")
        cppman.open_cppman_for(vim.fn.expand("<cword>"))
      end,
      desc = "Search CPPMan",
    },
    {
      mode = "n",
      lhs = "H",
      rhs = function()
        local count = vim.v.count1
        vim.cmd(count .. "bprevious")
      end,
      desc = "Prev Buffer",
    },
    {
      mode = "n",
      lhs = "L",
      rhs = function()
        local count = vim.v.count1
        vim.cmd(count .. "bnext")
      end,
      desc = "Next Buffer",
    },
    {
      mode = "n",
      lhs = "<leader>gx",
      rhs = function()
        local path = vim.fn.expand("<cfile>")
        vim.ui.open("https://github.com/" .. path)
      end,
      desc = "Open package in GitHub",
    },
  },
  gitsigns = function()
    local gitsigns = require("gitsigns")
    return {
      -- Navigation
      {
        mode = "n",
        lhs = "]h",
        rhs = function()
          if vim.wo.diff then
            vim.cmd.normal({ "]h", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end,
        { desc = "Next [h]unk" },
      },
      {
        mode = "n",
        lhs = "[h",
        rhs = function()
          if vim.wo.diff then
            vim.cmd.normal({ "[h", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end,
        { desc = "Previous [h]unk" },
      },

      -- Actions
      {
        mode = "n",
        lhs = "<leader>gs",
        rhs = gitsigns.stage_hunk,
        { desc = "[g]it [s]tage hunk" },
      },
      {
        mode = "n",
        lhs = "<leader>gr",
        rhs = gitsigns.reset_hunk,
        { desc = "[g]it [r]eset hunk" },
      },
      {
        mode = "v",
        lhs = "<leader>gs",
        rhs = function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        { desc = "[g]it [s]tage hunk" },
      },
      {
        mode = "v",
        lhs = "<leader>gr",
        rhs = function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        { desc = "[g]it [r]eset hunk" },
      },
      {
        mode = "n",
        lhs = "<leader>gS",
        rhs = gitsigns.stage_buffer,
        { desc = "[g]it [S]tage buffer" },
      },
      {
        mode = "n",
        lhs = "<leader>gR",
        rhs = gitsigns.reset_buffer,
        { desc = "[g]it [R]eset buffer" },
      },
      {
        mode = "n",
        lhs = "<leader>gp",
        rhs = gitsigns.preview_hunk,
        { desc = "[g]it [p]review hunk" },
      },
      {
        mode = "n",
        lhs = "<leader>gi",
        rhs = gitsigns.preview_hunk_inline,
        { desc = "[g]it preview hunk [i]nline" },
      },
      {
        mode = "n",
        lhs = "<leader>gb",
        rhs = function()
          gitsigns.blame_line({ full = true })
        end,
        { desc = "[g]it [b]lame line" },
      },
      {
        mode = "n",
        lhs = "<leader>gd",
        rhs = gitsigns.diffthis,
        { desc = "[g]it [d]iff" },
      },
      {
        mode = "n",
        lhs = "<leader>gD",
        rhs = function()
          gitsigns.diffthis("~")
        end,
        { desc = "[g]it [D]iff (previous commit)" },
      },
      {
        mode = "n",
        lhs = "<leader>gQ",
        rhs = function()
          gitsigns.setqflist("all")
        end,
        { desc = "[g]it add all hunks to [Q]uickfix" },
      },
      {
        mode = "n",
        lhs = "<leader>gq",
        rhs = gitsigns.setqflist,
        { desc = "[g]it add hunk to [q]uickfix" },
      },

      -- Toggles
      {
        mode = "n",
        lhs = "<leader>tb",
        rhs = gitsigns.toggle_current_line_blame,
        { desc = "[t]oggle [b]lame" },
      },
      {
        mode = "n",
        lhs = "<leader>tw",
        rhs = gitsigns.toggle_word_diff,
        { desc = "[t]oggle [w]ord diff" },
      },

      -- Text object
      {
        mode = { "o", "x" },
        lhs = "ih",
        rhs = gitsigns.select_hunk,
        { desc = "inner hunk" },
      },
    }
  end,
  telescope = {
    { mode = "n", lhs = "<leader>sh", rhs = builtin.help_tags, desc = "[S]earch [H]elp" },
    { mode = "n", lhs = "<leader>sk", rhs = builtin.keymaps, desc = "[S]earch [K]eymaps" },
    { mode = "n", lhs = "<leader>sf", rhs = builtin.find_files, desc = "[S]earch [F]iles" },
    { mode = "n", lhs = "<leader>ss", rhs = builtin.lsp_document_symbols, desc = "[S]earch document [s]ymbols" },
    { mode = "n", lhs = "<leader>sS", rhs = builtin.lsp_workspace_symbols, desc = "[S]earch workspace [S]ymbols" },
    { mode = "n", lhs = "<leader>sw", rhs = builtin.grep_string, desc = "[S]earch current [W]ord" },
    { mode = "n", lhs = "<leader>sg", rhs = builtin.live_grep, desc = "[S]earch by [G]rep" },
    { mode = "n", lhs = "<leader>sd", rhs = builtin.diagnostics, desc = "[S]earch [D]iagnostics" },
    { mode = "n", lhs = "<leader>sr", rhs = builtin.resume, desc = "[S]earch [R]esume" },
    {
      mode = "n",
      lhs = "<leader>s.",
      rhs = builtin.oldfiles,
      desc = '[S]earch Recent Files ("." for repeat)',
    },
    { mode = "n", lhs = "<leader><leader>", rhs = builtin.buffers, desc = "[ ] Find existing buffers" },

    -- Slightly advanced example of overriding default behavior and theme
    {
      mode = "n",
      lhs = "<leader>/",
      rhs = function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end,
      desc = "[/] Fuzzily search in current buffer",
    },

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    {
      mode = "n",
      lhs = "<leader>s/",
      rhs = function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end,
      desc = "[S]earch [/] in Open Files",
    },

    -- Shortcut for searching your Neovim configuration files
    {
      mode = "n",
      lhs = "<leader>sn",
      rhs = function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "[S]earch [N]eovim files",
    },
  },
  markdownPreview = {
    {
      mode = "n",
      lhs = "<leader>p",
      rhs = "<cmd>MarkdownPreviewToggle<cr>",
      desc = "Toggle markdown preview",
    },
  },
  trouble = {
    {
      mode = "n",
      lhs = "<leader>xx",
      rhs = "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      mode = "n",
      lhs = "<leader>xX",
      rhs = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      mode = "n",
      lhs = "<leader>cs",
      rhs = "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      mode = "n",
      lhs = "<leader>cl",
      rhs = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      mode = "n",
      lhs = "<leader>xL",
      rhs = "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      mode = "n",
      lhs = "<leader>xQ",
      rhs = "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
  todoComments = {
    {
      mode = "n",
      lhs = "]t",
      rhs = function()
        require("todo-comments").jump_next()
      end,
      desc = "Next Todo Comment",
    },
    {
      mode = "n",
      lhs = "[t",
      rhs = function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous Todo Comment",
    },
    {
      mode = "n",
      lhs = "<leader>xt",
      rhs = "<cmd>Trouble todo toggle<cr>",
      desc = "Todo (Trouble)",
    },
    {
      mode = "n",
      lhs = "<leader>xT",
      rhs = "<cmd>Trouble todo toggle filter = {tag = {TODO,rhs=FIX,FIXME}}<cr>",
      desc = "Todo/Fix/Fixme (Trouble)",
    },
    {
      mode = "n",
      lhs = "<leader>st",
      rhs = "<cmd>TodoTelescope<cr>",
      desc = "Todo",
    },
    {
      mode = "n",
      lhs = "<leader>sT",
      rhs = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
      desc = "Todo/Fix/Fixme",
    },
  },
  lsp = {
    {
      mode = "n",
      lhs = "grn",
      rhs = vim.lsp.buf.rename,
      desc = "Rename",
    },
    {
      mode = { "n", "x" },
      lhs = "gra",
      rhs = vim.lsp.buf.code_action,
      desc = "Code Action",
    },
    {
      mode = "n",
      lhs = "grr",
      rhs = builtin.lsp_references,
      desc = "Goto References",
    },
    {
      mode = "n",
      lhs = "gri",
      rhs = builtin.lsp_implementations,
      desc = "Goto Implementation",
    },
    {
      mode = "n",
      lhs = "gd",
      rhs = builtin.lsp_definitions,
      desc = "Goto Definition",
    },
    {
      mode = "n",
      lhs = "gD",
      rhs = vim.lsp.buf.declaration,
      desc = "Goto Declaration",
    },
    {
      mode = "n",
      lhs = "gs",
      rhs = builtin.lsp_document_symbols,
      desc = "Goto Document symbols",
    },
    {
      mode = "n",
      lhs = "gS",
      rhs = builtin.lsp_workspace_symbols,
      desc = "Goto Workspace Symbols",
    },
    {
      mode = "n",
      lhs = "gt",
      rhs = vim.lsp.buf.type_definition,
      desc = "Goto Type Definition",
    },
  },
  flutter = {
    { mode = "n", lhs = "<leader>fr", rhs = "<cmd>FlutterRun<CR>", desc = "Run the current project" },
    {
      mode = "n",
      lhs = "<leader>fd",
      rhs = "<cmd>FlutterDebug<CR>",
      desc = " Force run current project in debug mode.",
    },
    {
      mode = "n",
      lhs = "<leader>fld",
      rhs = "<cmd>FlutterDevices<CR>",
      desc = " Brings up a list of connected devices to select from.",
    },
    {
      mode = "n",
      lhs = "<leader>fle",
      rhs = "<cmd>FlutterEmulators<CR>",
      desc = " Similar to devices but shows a list of emulators to choose from.",
    },
    { mode = "n", lhs = "<leader>fpr", rhs = "<cmd>FlutterReload<CR>", desc = " Reload the running project." },
    { mode = "n", lhs = "<leader>fpR", rhs = "<cmd>FlutterRestart<CR>", desc = " Restart the current project." },
    { mode = "n", lhs = "<leader>fq", rhs = "<cmd>FlutterQuit<CR>", desc = " Ends a running session." },
    { mode = "n", lhs = "<leader>fa", rhs = "<cmd>FlutterAttach<CR>", desc = " Attach to a running app." },
    {
      mode = "n",
      lhs = "<leader>fD",
      rhs = "<cmd>FlutterDetach<CR>",
      desc = " Ends a running session locally but keeps the process running on the device.",
    },
    {
      mode = "n",
      lhs = "<leader>to",
      rhs = "<cmd>FlutterOutlineToggle<CR>",
      desc = " Toggle the outline window showing the widget tree for the given file.",
    },
    {
      mode = "n",
      lhs = "<leader>fo",
      rhs = "<cmd>FlutterOutlineOpen<CR>",
      desc = " Opens an outline window showing the widget tree for the given file.",
    },
    {
      mode = "n",
      lhs = "<leader>fts",
      rhs = "<cmd>FlutterDevTools<CR>",
      desc = " Starts a Dart Dev Tools server.",
    },
    {
      mode = "n",
      lhs = "<leader>fta",
      rhs = "<cmd>FlutterDevToolsActivate<CR>",
      desc = " Activates a Dart Dev Tools server.",
    },
    {
      mode = "n",
      lhs = "<leader>fu",
      rhs = "<cmd>FlutterCopyProfilerUrl<CR>",
      desc = " Copies the profiler url to your system clipboard (+ register). Note that commands FlutterRun and FlutterDevTools must be executed first.",
    },
    {
      mode = "n",
      lhs = "<leader>fL",
      rhs = "<cmd>FlutterLspRestart<CR>",
      desc = " This command restarts the dart language server, and is intended for situations where it begins to work incorrectly.",
    },
    {
      mode = "n",
      lhs = "grs",
      rhs = "<cmd>FlutterSuper<CR>",
      desc = " Go to super class, method using custom LSP method dart/textDocument/super.",
    },
    {
      mode = "n",
      lhs = "gR",
      rhs = "<cmd>FlutterReanalyze<CR>",
      desc = " Forces LSP server reanalyze using custom LSP method dart/reanalyze.",
    },
    {
      mode = "n",
      lhs = "grn",
      rhs = "<cmd>FlutterRename<CR>",
      desc = " Renames and updates imports if lsp.settings.renameFilesWithClasses == always",
    },
    { mode = "n", lhs = "<leader>fc", rhs = "<cmd>FlutterLogClear<CR>", desc = " Clears the log buffer." },
    { mode = "n", lhs = "<leader>tfl", rhs = "<cmd>FlutterLogToggle<CR>", desc = " Toggles the log buffer." },
  },
  dap = {
    {
      mode = "n",
      lhs = "<leader>d",
      rhs = function()
        local dap = require("dap")
        if dap.session() ~= nil then
          DEBUG_MODE:activate()
          return
        end
        dap.continue()
      end,
      desc = "launch debugger",
    },
    {
      mode = "n",
      -- NOTE: this overrides the default bprev binding
      lhs = "[b",
      rhs = function()
        require("config.breakpoints").prev()
      end,
      desc = "Previous breakpoint",
    },
    {
      mode = "n",
      lhs = "]b",
      rhs = function()
        require("config.breakpoints").next()
      end,
      desc = "Next breakpoint",
    },
    {
      mode = "n",
      lhs = "<leader>b",
      rhs = function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle breakpoint",
    },
  },
}

---@param key Key
function M.map(key)
  vim.keymap.set(key.mode, key.lhs, key.rhs, { desc = key.desc })
end

---@module "lazy.types"
---@param keys Key[]
---@return LazyKeysSpec[]
function M.lazyspec(keys)
  ---@type LazyKeysSpec[]
  local lazykeys = {}
  for _, key in pairs(keys) do
    table.insert(lazykeys, { key.lhs, key.rhs, mode = key.mode, desc = key.desc })
  end
  return lazykeys
end

---@param key Key
---@param bufnr integer
function M.maplocal(key, bufnr)
  if key.lhs == nil then
    print(vim.inspect(key))
  end
  vim.keymap.set(key.mode, key.lhs, key.rhs, { desc = key.desc, buffer = bufnr })
end

return M
