-- Configuration for integrating Ollama into Neovim
return {
  "David-Kunz/gen.nvim",
  opts = {
    model = "llama3", -- Default model
    host = "localhost",
    port = "11434",

    quit_map = "q",      -- Keymap for cloding response
    retry_map = "<c-r>", -- keymap for closing the response window

    -- Function to initialize Ollama
    init = function(options)
      pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
    end,

    command = function(options)
      local body = { model = options.model, stream = true }
      return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
    end,
    -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
    -- This can also be a command string.
    -- The executed command must return a JSON object with { response, context }
    -- (context property is optional).
    display_mode = "split", -- Display mode. Can be "float" or "split".
    show_prompt = false,    -- Shows the prompt submitted to Ollama
    show_model = false,     -- Displays which model you are using
    no_auto_close = true,   -- Never closes the window automatically
    debug = false,          -- Prints errors and the command which is run
  },

  cmd = "Gen",
  keys = {
    {
      "<leader>oc",
      ':Gen<CR>',
      silent = true,
      desc = "[O]pen [C]hat",
    }
  }

}
