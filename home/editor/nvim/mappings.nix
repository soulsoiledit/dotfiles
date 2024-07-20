{
  programs.nixvim.keymaps = [
    {
      # clear on escape
      mode = "n";
      key = "<Esc>";
      action = "<cmd>noh<CR>";
    }

    {
      mode = "n";
      key = "<tab>";
      action = "<cmd>bnext<cr>";
    }

    {
      mode = "n";
      key = "<s-tab>";
      action = "<cmd>bprev<cr>";
    }

    # TODO: add buffer/window maps
    # buffers/windows
  ];
}
