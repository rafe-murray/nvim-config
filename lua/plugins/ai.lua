return {
  {
    "Robitx/gp.nvim",
    config = function()
      local conf = {
        providers = {
          googleai = {
            disable = false,
            secret = os.getenv("GEMINI_API_KEY"),
          },
        },
        agents = {
          {
            provider = "googleai",
            name = "ChatGemini",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gemini-2.5-flash", temperature = 1.1, top_p = 1 },
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
          {
            provider = "googleai",
            name = "CodeGemini",
            chat = false,
            command = true,
            model = { model = "gemini-2.5-flash", temperature = 0.8, top_p = 1 },
            system_prompt = require("gp.defaults").code_system_prompt,
          },
        },
      }
      require("gp").setup(conf)
    end,
  },
}
