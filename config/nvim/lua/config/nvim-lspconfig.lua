-- TODO: Rethink if some of this config is better suited living within a plugin
-- i.e. FzfLua keybinding in fzf-lua.lua config file, vim stuff moved to vim-opts.lua
--
-- Enhanced capabilities for blink.cmp integration
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Setup on_attach with diagnostic keymappings only
local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "K", "<cmd>FzfLua lsp_hover<cr>", bufopts)
end

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Server configurations with your priorities
local servers = {
	gopls = {},
	ruff = {},
	ty = {
		cmd = {
			"ty",
			"server",
		},
		filetypes = { "python" },
		root_dir = {
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			"requirements.txt",
		},
	},
	bashls = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
				},
			},
		},
	},
	marksman = {},
}
local lspconfig = {}
for server, config in pairs(servers) do
	lspconfig[server] = {
		on_attach = on_attach,
		capabilities = capabilities,
		-- It's better not to set settings at all than to make them an empty table
		-- settings = config.settings or {},
		-- init_options = config.init_options or {},
		settings = config.settings or nil,
		init_options = config.init_options or nil,
	}
	vim.lsp.config(server, lspconfig[server])
	vim.lsp.enable(server)
end
