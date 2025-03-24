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
      key = "<leader>r";
      action = "<cmd>w<cr>";
      options.desc = "write";
    }

    {
      mode = "n";
      key = "<esc>";
      action = "<cmd>noh<cr>";
      options.desc = "clear hlsearch";
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
