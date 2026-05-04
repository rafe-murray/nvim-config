return {
  { "MunifTanjim/nui.nvim" },
  { "nvim-lua/plenary.nvim" },
  {
    "folke/tokyonight.nvim",
    opts = {
      priority = 1000,
      transparent = true,
      -- TODO: finish this
      ---@param cl Palette
      -- on_colors = function(cl)
      --   -- General idea: make the colorscheme look like a sunset
      --   -- strings are a bright medium saturation yellow-orange
      --   -- macros are
      --
      --   -- strings
      --   cl.green = "#ffdf7d"
      --
      --   -- functions
      --   cl.blue = "#fd87c9"
      --
      --   cl.blue0 = "#fe7498"
      --
      --   -- classes
      --   cl.blue1 = "#ff7162"
      --
      --   -- Properties
      --   cl.green1 = "#a5bcff" -- "#dba7ff"
      --   cl.cyan = "#ff5441"
      --
      --   -- Parameters
      --   cl.yellow = "#fcc244"
      --
      --   -- properties
      --   -- cl.red = "#dba7ff"
      --   -- cl.red1 = "#dba7ff"
      --
      --   -- constants
      --   cl.orange = "#95faff"
      --
      --   -- mixed for control statements
      --   -- cl.magenta = "#ed5fb4"
      --   -- cl.magenta2 = "#e9775f"
      --
      --   -- builtins
      --   cl.purple = "#fd9940"
      -- end,
    },
  },
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   priority = 1000, -- Ensure it loads first
  --   opts = {
  --     colors = {
  --       bg = "#282c34",
  --       fg = "#abb2bf",
  --       red = "#db3b6b",
  --       orange = "#e37712",
  --       yellow = "#fcc244",
  --       green = "#98c379",
  --       cyan = "#2ac3de",
  --       blue = "#5a95ff",
  --       purple = "#db4b4b",
  --       white = "#abb2bf",
  --       black = "#282c34",
  --       gray = "#5c6370",
  --       highlight = "#e2be7d",
  --       comment = "#7f848e",
  --       none = "NONE",
  --     },
  --     options = {
  --       transparency = true,
  --       lualine_transparency = true,
  --     },
  --   },
  -- },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      globalstatus = true,
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@module "snacks"
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
