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
})

hl(0, "MarkviewListItemMinus", { link = "MarkviewPalette6Fg" })
hl(0, "MarkviewListItemStar", { link = "MarkviewPalette2Fg" })
