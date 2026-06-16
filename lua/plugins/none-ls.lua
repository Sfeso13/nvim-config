return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.ruff,
      },

      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.keymap.set(
            "n",
            "<leader>f",
            function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
            { buffer = bufnr, desc = "Format file" }
          )
        end
      end,
    })
  end,
}

