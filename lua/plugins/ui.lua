return {
  { "MunifTanjim/nui.nvim" },
  { "nvim-lua/plenary.nvim" },
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      style = "warmer",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      priority = 1000,
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        buffer_close_icon = "",
        close_icon = "",
        separator_style = "slant",
        numbers = "buffer_id",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            separator = true,
            text_align = "left",
          },
        },
      },
    },
  },
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
    ---@type snacks.Config
    opts = {
      statuscolumn = { enabled = true },
    },
  },
  {
    "3rd/image.nvim",
    opts = {},
  },
  -- {
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --   opts = {
  --     theme = "doom",
  --     config = {
  --       disable_move = true,
  --       header = {
  --         "",
  --         "",
  --         "",
  --         "███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗",
  --         "████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║",
  --         "██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║",
  --         "██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║",
  --         "██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║",
  --         "╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝",
  --         "",
  --         "",
  --       }, --your header
  --       center = {
  --         {
  --           desc = "Find Files",
  --           key = "f",
  --           key_format = " %s", -- remove default surrounding `[]`
  --           action = "Telescope oldfiles",
  --         },
  --         {
  --           desc = "Edit config",
  --           key = "c",
  --           key_format = " %s", -- remove default surrounding `[]`
  --           action = "edit ~/.config/nvim/lua",
  --         },
  --         {
  --           desc = "Lazy",
  --           key = "l",
  --           key_format = " %s", -- remove default surrounding `[]`
  --           action = "Lazy",
  --         },
  --       },
  --       footer = {}, --your footer
  --     },
  --   },
  --   -- config = function()
  --   --   require('dashboard').setup {
  --   --     -- config
  --   --   }
  --   -- end,
  --   dependencies = { { "nvim-tree/nvim-web-devicons" } },
  -- },
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
}
