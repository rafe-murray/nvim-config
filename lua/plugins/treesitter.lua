return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
    end,
    cmd = { "TSUpdate", "TSInstall" },
    opts = {},
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    enabled = true,
    opts = {
      select = {
        selection_modes = {
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "V",
          ["@scope.outer"] = "V",
        },
      },
      move = {
        set_jumps = false,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)
      ---@type Keymaps
      local keymaps = require("config.keymaps")
      for _, key in pairs(keymaps.treesitter) do
        keymaps.map(key)
      end
    end,
  },
}
