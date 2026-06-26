return {
  "stevearc/conform.nvim",

  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        
        html = { "prettier"},
        css = { "prettier"},
        scss = { "prettier"},

        lua = { "stylua" },
        python = { "black" },
        c = { "clang_format" },
        cpp = { "clang_format" },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })

    -- optional manual keybind
    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({ lsp_fallback = true })
    end, { desc = "Format file" })
  end,
}
