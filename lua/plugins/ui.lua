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
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
}
