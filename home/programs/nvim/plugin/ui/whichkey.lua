later(function()
  vim.cmd("packadd which-key.nvim")
  require("which-key").setup({
    spec = {
      { "gra", desc = "code action" },
      { "gri", desc = "go to implementation" },
      { "grn", desc = "rename" },
      { "grr", desc = "go to reference" },
      { "grt", desc = "go to type definition" },
    },
  })
end)
