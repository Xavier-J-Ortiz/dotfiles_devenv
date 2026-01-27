-- TODO: possible to break up this plugin into separate config files.
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    -- Primary goto definitions
    { "gd", "<cmd>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>", desc = "Goto Definition" },
    { "gD", "<cmd>FzfLua lsp_declarations<cr>", desc = "Goto Declaration" },
    { "gr", "<cmd>FzfLua lsp_references<cr>", desc = "Goto References" },
    { "gi", "<cmd>FzfLua lsp_implementations<cr>", desc = "Goto Implementation" },
    -- Symbol navigation
    { "<leader>cw", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
    -- Research mode (alternative to trouble.nvim LSP)
    { "<leader>cl", "<cmd>FzfLua lsp_finder<cr>", desc = "LSP All Locations" },
  },
  opts = {
    -- LSP-specific optimizations
    lsp = {
      jump1 = true,
      async_or_timeout = 5000,
      timeout = 30000,
    },
    -- Global fzf-lua settings
    fzf_opts = {
      ["--ansi"] = true,
      ["--info"] = "inline-right",
      ["--height"] = "100%",
      ["--layout"] = "reverse",
      ["--border"] = "none",
      ["--highlight-line"] = true,
    },
    -- Window settings
    winopts = {
      height = 0.85,
      width = 0.80,
      border = "rounded",
    },
    -- Fast minimal previews (can enhance later)
    previewer = "builtin",
    file_icons = true,
    git_icons = false,
  }
}
