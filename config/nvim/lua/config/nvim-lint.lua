require("lint").linters_by_ft = {
	-- There are other linters that are loaded for filetypes not specified here.
	-- One is `vale` for `markdown`. These not specified linters are found in the
	-- ~/.local/share/nvim/lazy/nvim-lint/lua/lint.lua file
	go = { "golangci-lint" },
	python = { "ruff" },
	lua = { "luacheck" },
	bash = { "shellcheck" },
	markdown = { "vale", "markdownlint-cli2" },
	text = { "vale" },
	rst = { "vale" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
