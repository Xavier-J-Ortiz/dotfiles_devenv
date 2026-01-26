require('config.lazy')
vim.opt.number = true
--[[
vim.cmd('hi Normal ctermbg=NONE guibg=NONE')
vim.cmd('hi NonText ctermbg=NONE guibg=NONE')
--]]
-- vim.cmd.colorscheme "tokyonight-storm"

-- Keymaps for diagnostics of errors/warnings/etc
-- All the below are done already natively. 
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float) -- <C-w>d
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
