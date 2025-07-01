return {
  {
    "markview.nvim",
    lazy = false,
    priority = 45,
    after = function()
      require("markview").setup({
        markdown = {
          list_items = {
            shift_width = function(buffer, item)
              local shiftwidth = vim.bo[buffer].shiftwidth
              local prev = math.ceil(item.indent / shiftwidth + 1)
              local final = math.ceil(item.indent / shiftwidth) * shiftwidth
              return final / prev
            end,
          },
        },

        experimental = { check_rtp_message = false, },
      })

      vim.api.nvim_set_hl(0, "MarkviewListItemMinus", { link = "MarkviewPalette6Fg" })
      vim.api.nvim_set_hl(0, "MarkviewListItemStar", { link = "MarkviewPalette2Fg" })

      require("lz.n").trigger_load("nvim-treesitter")
    end,
  },
}
