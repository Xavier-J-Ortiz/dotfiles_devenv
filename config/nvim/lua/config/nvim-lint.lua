require("lint").linters_by_ft = {
	go = { "golangcilint" },
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
