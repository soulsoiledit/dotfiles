return {
  {
    "grug-far.nvim",
    cmd = "GrugFar",
    after = function()
      require("grug-far").setup()
    end,
  },
}
