return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.config("clangd", {})
		-- Configure Pyright to look for a local virtual environment
		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "openFilesOnly",
					},
				},
			},
			before_init = function(_, config)
				-- Automatically check for typical venv directories in the project root
				local env_path = vim.fn.getcwd() .. "/.venv"
				if vim.fn.executable(env_path .. "/bin/python") == 1 then
					config.settings.python.pythonPath = env_path .. "/bin/python"
				elseif vim.fn.executable(env_path .. "/Scripts/python.exe") == 1 then -- Windows fallback
					config.settings.python.pythonPath = env_path .. "/Scripts/python.exe"
				end
			end,
		})
		vim.lsp.config("lua_ls", {})
		vim.lsp.config("ts_ls", {})

		vim.lsp.enable({ "clangd", "pyright", "lua_ls", "ts_ls" })

		vim.diagnostic.config({
			virtual_text = false, -- Turn off the single-line inline text
			virtual_lines = { -- Turn on multi-line text underneath the code
				current_line = true, -- Only show it for the line your cursor is on (keeps code clean)
			},
			signs = true,
			underline = true,
			severity_sort = true,
		})

		-- LSP keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local opts = { buffer = event.buf, silent = true }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})
	end,
}
