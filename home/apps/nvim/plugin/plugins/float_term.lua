function floating_term(cmd)
  local editor_width = vim.o.columns
  local editor_height = vim.o.lines

  local dim_buf = vim.api.nvim_create_buf(false, true)
  local dim_win = vim.api.nvim_open_win(dim_buf, false, {
    relative = "editor",
    width = editor_width,
    height = editor_height,
    row = 0,
    col = 0,
    style = "minimal",
    focusable = false
  })
  vim.wo[dim_win].winblend = 50
  vim.wo[dim_win].winhighlight = "NormalFloat:Normal"

  local float_width = math.floor(editor_width * 0.9)
  local float_height = math.floor(editor_height * 0.9)
  local float_buf = vim.api.nvim_create_buf(false, true)
  local float_win = vim.api.nvim_open_win(float_buf, true, {
    relative = "editor",
    width = float_width,
    height = float_height,
    row = math.floor((editor_height - float_height) / 2),
    col = math.floor((editor_width - float_width) / 2),
    style = "minimal"
  })
  vim.wo[float_win].winhighlight = "NormalFloat:Normal"

  vim.fn.jobstart(cmd, {
    term = true,
    on_exit = function ()
      vim.api.nvim_win_close(dim_win, true)
      vim.api.nvim_buf_delete(dim_buf, { force = true })

      vim.api.nvim_win_close(float_win, true)
      vim.api.nvim_buf_delete(float_buf, { force = true })

      vim.cmd.checktime()
    end
  })
end
