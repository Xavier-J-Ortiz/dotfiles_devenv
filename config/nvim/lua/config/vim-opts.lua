vim.opt.number = true
-- spelling
local spell_dir = vim.fn.stdpath("config") .. "/spell"
vim.fn.mkdir(spell_dir, "p")
vim.opt.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

vim.opt.tabstop = 4 -- Displayed width of a tab
vim.opt.shiftwidth = 4 -- How much is moved on >>
vim.opt.softtabstop = 4 -- Inserts 4 spaces if Tab is set, and expandtab is true
vim.opt.expandtab = true -- On enable, inserts spaces instead of tab.
-- disable mouse support
vim.opt.mouse = ""
