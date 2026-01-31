return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	--[[
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
  },
  --]]
	config = function()
		require("config.mason-tool-installer")
	end,
	enabled = true,
}
