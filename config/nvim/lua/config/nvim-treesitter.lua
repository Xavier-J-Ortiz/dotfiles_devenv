require("nvim-treesitter").setup({ install_dir = vim.fn.stdpath("data") .. "/site" })
-- wait required so that there is no error when bootstrapping plugins on first run.
require("nvim-treesitter").install({ "lua", "vimdoc", "markdown" }):wait(300000)
