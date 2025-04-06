return {
  {
    "lsp-format.nvim",
    lazy = true,
    after = function()
      require("lsp-format").setup({
        -- nil/vim.lsp doesn't really support disabling formatting by client...
        nix = { exclude = { "nil" } }
      })
    end,
  },
}
