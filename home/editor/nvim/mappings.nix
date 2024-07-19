{
  programs.nixvim.keymaps = [
    {
      mode = [
        "n"
        "x"
      ];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        expr = true;
        silent = true;
      };
    }
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
