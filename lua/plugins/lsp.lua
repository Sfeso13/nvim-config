return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- === LSP Keymaps (attached per buffer) ===
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

      -- Disable formatting for Pyright (handled by none-ls)
      if client.name == "pyright" then
        client.server_capabilities.documentFormattingProvider = false
      end
    end

    -- === Clangd (C/C++) ===
    vim.lsp.config("clangd", {
      cmd = { "clangd", "--background-index", "--clang-tidy" },
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable("clangd")

    -- === Pyright (Python) ===
    vim.lsp.config("pyright", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    })
    vim.lsp.enable("pyright")
  end,
}

