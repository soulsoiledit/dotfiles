{
  programs.nixvim.plugins = {
    toggleterm = {
      enable = true;
      settings = {
        open_mapping = "[[<leader>t]]";
        insert_mappings = false;
        autochdir = true;
      };
    };
  };
}
