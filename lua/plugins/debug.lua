return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "debugloop/layers.nvim",
        opts = {},
      },
    },
    keys = {
      {
        "<leader>d",
        function()
          local dap = require("dap")
          if dap.session() ~= nil then
            DEBUG_MODE:activate()
            return
          end
          dap.continue()
        end,
        desc = "launch debugger",
      },
    },
    opts = { ... },
    config = function(_, opts)
      local dap = require("dap")
      -- do the setup you'd do anyway for your language of choice
      dap.adapters = opts.adapters
      dap.configurations = opts.configurations
      -- this is where the example starts
      DEBUG_MODE = require("layers").mode.new() -- global, accessible from anywhere
      DEBUG_MODE:auto_show_help()
      -- this actually relates to the next example, but it is most convenient to add here
      DEBUG_MODE:add_hook(function(_)
        vim.cmd("redrawstatus") -- update status line when toggled
      end)
      -- nvim-dap hooks
      dap.listeners.after.event_initialized["debug_mode"] = function()
        DEBUG_MODE:activate()
      end
      dap.listeners.before.event_terminated["debug_mode"] = function()
        DEBUG_MODE:deactivate()
      end
      dap.listeners.before.event_exited["debug_mode"] = function()
        DEBUG_MODE:deactivate()
      end
      -- map our custom mode keymaps
      DEBUG_MODE:keymaps({
        n = {
          {
            "s",
            function()
              dap.step_over()
            end,
            { desc = "step forward" },
          },
          {
            "c",
            function()
              dap.continue()
            end,
            { desc = "continue" },
          },
          { -- this acts as a way to leave debug mode without quitting the debugger
            "<esc>",
            function()
              DEBUG_MODE:deactivate()
            end,
            { desc = "exit" },
          },
          -- and so on...
        },
      })
    end,
  },
}
