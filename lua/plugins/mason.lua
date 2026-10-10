return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"typos_lsp",
				"pyright",
				"lua_ls",
				"ts_ls",
			},
		})
	end,
}
