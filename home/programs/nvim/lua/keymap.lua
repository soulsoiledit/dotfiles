vim.keymap.set(
  "n", "<leader>q", "<cmd>q<cr>",
  { desc = "quit" }
)

vim.keymap.set(
  "n", "<leader>r", "<cmd>w<cr>",
  { desc = "write" }
)

vim.keymap.set(
  "n", "<leader>x", "<cmd>bdelete<cr>",
  { desc = "close" }
)

vim.keymap.set(
  "n", "<esc>", "<cmd>noh<cr>",
  { desc = "clear hl" }
)

vim.keymap.set(
  "n", "<leader>w", "<c-w>",
  { desc = "window" }
)
