local keymaps = require("config.keymaps")
local dapKeys = keymaps.lazyspec(keymaps.dap)
---@module "lazy.types"
return {
  ---@type LazySpec
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "debugloop/layers.nvim",
        opts = {},
      },
      {
        "telescope.nvim",
      },
    },
    keys = dapKeys,
    opts = {
      adapters = {
        lldb = {
          type = "executable",
          command = "/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap", -- Must be absolute
          name = "lldb",
        },
      },
      configurations = {
        cpp = {
          {
            name = "Launch",
            type = "lldb",
            request = "launch",
            program = function()
              return coroutine.create(function(dap_run)
                local actions = require("telescope.actions")
                local actionState = require("telescope.actions.state")
                local cwd = vim.fn.getcwd() .. "/build"
                require("telescope.builtin").find_files({
                  prompt_title = "Select Executable to Debug",
                  find_command = {
                    "fd",
                    "--type",
                    "x",
                    "--color",
                    "never",
                  },
                  cwd = cwd,
                  attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(function()
                      local selection = actionState.get_selected_entry()
                      actions.close(prompt_bufnr)
                      coroutine.resume(dap_run, cwd .. "/" .. selection[1])
                    end)
                    return true
                  end,
                })
              end)
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = true,
            args = {},

            -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
            --
            --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            --
            -- Otherwise you might get the following error:
            --
            --    Error on launch: Failed to attach to the target process
            --
            -- But you should be aware of the implications:
            -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
            -- runInTerminal = false,
          },
        },
      },
    },
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
        if DEBUG_MODE.active(DEBUG_MODE) then
          DEBUG_MODE:deactivate()
        end
      end
      -- dap.listeners.before.event_exited["debug_mode"] = function()
      --   DEBUG_MODE:deactivate()
      -- end
      -- map our custom mode keymaps
      DEBUG_MODE:keymaps({
        n = {
          {
            "n",
            function()
              for _ = 0, vim.v.count1 do
                dap.step_over()
              end
            end,
            { desc = "step over" },
          },
          {
            "s",
            function()
              for _ = 0, vim.v.count1 do
                dap.step_into()
              end
            end,
            { desc = "step into" },
          },
          {
            "b",
            function()
              dap.toggle_breakpoint()
            end,
            { desc = "toggle breakpoint" },
          },
          {
            "B",
            function()
              for _ = 0, vim.v.count1 do
                dap.step_back()
              end
            end,
            { desc = "step back" },
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
              if DEBUG_MODE.active(DEBUG_MODE) then
                DEBUG_MODE:deactivate()
              end
            end,
            { desc = "exit" },
          },
          -- and so on...
        },
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    opts = {},
  },
}
