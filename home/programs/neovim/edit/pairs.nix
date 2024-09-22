{
  programs.nixvim.plugins.mini.modules = {
    pairs = {
      mappings = {
        # don't insert pair when typing before a character
        # https://github.com/echasnovski/mini.nvim/issues/835
        "(".neigh_pattern = "[^\\][%s%)%]%}]";
        "[".neigh_pattern = "[^\\][%s%)%]%}]";
        "{".neigh_pattern = "[^\\][%s%)%]%}]";

        "\"".neigh_pattern = "[^%w][^%w]";
        "'".neigh_pattern = "[^%w][^%w]";
        "`".neigh_pattern = "[^%w][^%w]";
      };
    };

    surround = {
      mappings = {
        add = "gsa";
        delete = "gsd";
        replace = "gsc";

        find = "";
        find_left = "";
        highlight = "";
        update_n_lines = "";
      };
    };
  };
}
