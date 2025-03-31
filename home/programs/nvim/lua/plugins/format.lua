return {
  {
    "lsp-format.nvim",
    lazy = true,
    after = function()
      require("lsp-format").setup()
    end,
  },

  {
    "none-ls.nvim",
    event = "DeferredUIEnter",
    before = function()
      require("lz.n").trigger_load("lsp-format.nvim")
    end,
    after = function()
      local nonels = require("null-ls")
      nonels.setup({
        on_attach = require("lsp-format").on_attach,
        sources = {
          nonels.builtins.formatting.prettier.with({
            filetypes = {
              "yaml",
              "html",
              "scss",
              "less",
            },
          }),
        },
      })
    end,
  },
}
