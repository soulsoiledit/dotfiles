return {
  {
    "markview.nvim",
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
      })
    end,
    lazy = false,
    priority = 40,
  },

  { "markdown-preview.nvim", ft = "markdown" },
}
