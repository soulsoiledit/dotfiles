local nmap = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

vim.g.mapleader = " "

nmap("<leader>q", vim.cmd.quit, "quit")
nmap("<leader>q", vim.cmd.quit, "quit")
vim.keymap.set("n", "<leader>q", vim.cmd.quit)
nmap("<leader>w", vim.cmd.write, "write")
nmap("<leader>c", vim.cmd.bdelete, "close")
nmap("<esc>", vim.cmd.nohlsearch, "clear hl")
