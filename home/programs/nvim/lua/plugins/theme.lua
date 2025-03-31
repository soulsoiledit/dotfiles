return {
  --TODO: get colors from nix
  {
    "mini.base16",
    lazy = false,
    after = function()
      require("mini.base16").setup({
        palette = {
          base00 = "#0b0b0b",
          base01 = "#1c1c1c",
          base02 = "#2e2e2e",
          base03 = "#414141",
          base04 = "#a6a6a6",
          base05 = "#bebebe",
          base06 = "#d6d6d6",
          base07 = "#eeeeee",
          base08 = "#c87180",
          base09 = "#c67854",
          base0A = "#b08836",
          base0B = "#719e58",
          base0C = "#24a592",
          base0D = "#2d9dc1",
          base0E = "#b177b4",
          base0F = "#c0729c",
        },
      })
    end
  },

  -- {
  --   "mini.hues",
  --   after = function()
  --     require("mini.hues").setup({
  --       background = "#0b0b0b",
  --       foreground = "#bebebe",
  --     })
  --   end
  -- },

}
