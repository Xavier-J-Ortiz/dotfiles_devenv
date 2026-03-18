require("lint").linters_by_ft = {
	-- There are other linters that are loaded for filetypes not specified here.
	-- One is `vale` for `markdown`. These not specified linters are found in the
	-- ~/.local/share/nvim/lazy/nvim-lint/lua/lint.lua file
	go = { "golangci-lint" },
	python = {},
	lua = { "luacheck" },
	bash = { "shellcheck" },
	markdown = { "vale", "markdownlint-cli2", "codespell" },
	-- TODO: Add more linters for yaml and json
	yaml = { "codespell" },
	json = { "codespell" },
	text = { "vale", "codespell" },
	rst = { "vale", "codespell" },
	gitcommit = { "codespell", "gitlint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
