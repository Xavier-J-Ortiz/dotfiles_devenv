require('config.lazy')
vim.opt.number = true
-- Keymaps for diagnostics of errors/warnings/etc
-- All the below are done already natively.
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float) -- <C-w>d
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.cmd.colorscheme "tokyonight-storm"
