{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>q<cr>";
      options.desc = "quit";
    }

    {
      mode = "n";
      key = "<esc>";
      action = "<cmd>noh<cr>";
      options.desc = "clear hlsearch";
    }

    {
      mode = "n";
      key = "<tab>";
      action = "<cmd>bnext<cr>";
      options.desc = "buffer next";
    }

    {
      mode = "n";
      key = "<s-tab>";
      action = "<cmd>bprev<cr>";
      options.desc = "buffer prev";
    }

    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>bdelete<cr>";
      options.desc = "buffer close";
    }

    {
      mode = "n";
      key = "<leader>w";
      action = "<c-w>";
      options = {
        remap = true;
        desc = "window";
      };
    }
  ];
}
