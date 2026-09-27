return {
	"stevearc/conform.nvim",
	opts = {
		-- Map of filetype to formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_organize_imports", "ruff_format" },
			go = { "goimports", "gofumpt" },
			bash = { "shfmt" },
			markdown = { "prettier" },
			gitcommit = { "git_wrap" },
			-- Use the "*" filetype to run formatters on all filetypes.
			-- ["*"] = { "XYZ_Formatter" },
			-- Use the "_" filetype to run formatters on filetypes that don't
			-- have other formatters configured.
			["_"] = { "trim_whitespace", "trim_newlines" },
		},
		-- Override Prettier's default prose wrapping behavior
		formatters = {
			prettier = {
				prepend_args = { "--prose-wrap", "always", "--print-width", "80" },
			},
			git_wrap = {
				format = function(bufnr)
					-- Enfoce 72 char margin for buffer.
					vim.bo[bufnr].textwidth = 72
					-- run internal nvim command to format the entier file.
					vim.cmd("normal! gggqG")
				end,
			},
		},
		-- Set this to change the default values when calling conform.format()
		-- This will also affect the default values for format_on_save/format_after_save
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- If this is set, Conform will run the formatter on save.
		-- It will pass the table to conform.format().
		-- This can also be a function that returns the table.
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
		-- If this is set, Conform will run the formatter asynchronously after save.
		-- It will pass the table to conform.format().
		-- This can also be a function that returns the table.
		format_after_save = {
			lsp_format = "fallback",
		},
		-- Set the log level. Use `:ConformInfo` to see the location of the log file.
		log_level = vim.log.levels.ERROR,
		-- Conform will notify you when a formatter errors
		notify_on_error = true,
		-- Conform will notify you when no formatters are available for the buffer
		notify_no_formatters = true,
	},
}
