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
			gitcommit = {}, -- Use Git's native wrapping, not Conform.
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
		},
		-- Set this to change the default values when calling conform.format()
		-- This will also affect the default values for format_on_save/format_after_save
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- If this is set, Conform will run the formatter on save.
		-- It will pass the table to conform.format().
		-- This can also be a function that returns the table.
		format_on_save = function(bufnr)
			-- Keep Git's native wrapping while typing, but don't reformat an
			-- entire commit buffer (including Git's commented template) on save.
			if vim.bo[bufnr].filetype == "gitcommit" then
				return nil
			end

			return {
				lsp_format = "fallback",
				timeout_ms = 500,
			}
		end,
		-- If this is set, Conform will run the formatter asynchronously after save.
		-- It will pass the table to conform.format().
		-- This can also be a function that returns the table.
		format_after_save = function(bufnr)
			if vim.bo[bufnr].filetype == "gitcommit" then
				return nil
			end

			return { lsp_format = "fallback" }
		end,
		-- Set the log level. Use `:ConformInfo` to see the location of the log file.
		log_level = vim.log.levels.ERROR,
		-- Conform will notify you when a formatter errors
		notify_on_error = true,
		-- Conform will notify you when no formatters are available for the buffer
		notify_no_formatters = true,
	},
}
