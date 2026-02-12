require("lint").lint_by_ft = {
	-- There are other linters that are loaded for filetypes not specified here.
	-- One is `vale` for `markdown`. These not specified linters are found in the
	-- ~/.local/share/nvim/lazy/nvim-lint/lua/lint.lua file
	go = { "golangci-lint" },
	python = { "ruff" },
	lua = { "luacheck" },
	bash = { "shellcheck" },
	markdown = { "markdownlint-cli2", "vale" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		require("lint").try_lint()

		-- You can call `try_lint` with a linter name or a list of names to always
		-- run specific linters, independent of the `linters_by_ft` configuration
		-- require("lint").try_lint("cspell")
	end,
})
