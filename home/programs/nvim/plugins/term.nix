{
  programs.nixvim = {
    plugins = {
      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<leader>t]]";
          insert_mappings = false;
        };
      };
    };

    keymaps = [
      # escape for normal mode
      {
        mode = "t";
        key = "<esc>";
        action = "<C-\\><C-n>";
      }
      # ctrl-w prefix
      {
        mode = "t";
        key = "<C-w>";
        action = "<C-\\><C-n><C-w>";
      }
    ];
  };
}
