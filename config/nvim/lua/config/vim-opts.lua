vim.opt.number = true

vim.cmd.colorscheme "tokyonight-storm"

-- spelling
local spell_dir = vim.fn.stdpath('config') .. '/spell'
vim.fn.mkdir(spell_dir, "p")
vim.opt.spellfile = vim.fn.expand('~/.config/nvim/spell/en.utf-8.add')
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }
