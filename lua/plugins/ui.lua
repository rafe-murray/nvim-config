return {
  { "MunifTanjim/nui.nvim" },
  { "nvim-lua/plenary.nvim" },
  {
    "folke/tokyonight.nvim",
    opts = {
      priority = 1000,
      transparent = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/tokyonight.nvim" },
    opts = {
      options = {
        theme = "tokyonight",
      },
      globalstatus = true,
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      statuscolumn = { enabled = true },
      indent = {},
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    opts = {
      "css",
      "lua",
    },
    event = "BufEnter",
  },
}
