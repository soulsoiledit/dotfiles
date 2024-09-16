{
  programs.nixvim.keymaps = [
    {
      # clear on escape
      mode = "n";
      key = "<Esc>";
      action = "<cmd>noh<CR>";
      options.desc = "clear search highlighting";
    }

    {
      mode = "n";
      key = "<tab>";
      action = "<cmd>bnext<cr>";
      options.desc = "next buffer";
    }

    {
      mode = "n";
      key = "<s-tab>";
      action = "<cmd>bprev<cr>";
      options.desc = "prev buffer";
    }

    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>bdelete<cr>";
      options.desc = "close buffer";
    }
  ];
}
