{
  programs.nixvim = {
    plugins = {
      mini = {
        enable = true;
        modules = {
          ai = { };
          align = { };
          basics = {
            options.extra_ui = true;
            navigation = {
              windows = true;
              move_with_alt = true;
            };
          };
          bracketed = { };
          cursorword = { };
          icons = { };
          trailspace = { };

          pairs = {
            mappings = {
              # don't insert pair when typing before a character
              "(" = {
                action = "open";
                pair = "()";
                neigh_pattern = "[^\\][%s%)%]%}]";
              };
              "[" = {
                action = "open";
                pair = "[]";
                neigh_pattern = "[^\\][%s%)%]%}]";
              };
              "{" = {
                action = "open";
                pair = "{}";
                neigh_pattern = "[^\\][%s%)%]%}]";
              };

              "\"" = {
                action = "closeopen";
                pair = "\"\"";
                neigh_pattern = "[^%w][^%w]";
                register = {
                  cr = false;
                };
              };
              "'" = {
                action = "closeopen";
                pair = "''";
                neigh_pattern = "[^%w][^%w]";
                register = {
                  cr = false;
                };
              };
              "`" = {
                action = "closeopen";
                pair = "``";
                neigh_pattern = "[^%w][^%w]";
                register = {
                  cr = false;
                };
              };
            };
          };

          surround = {
            mappings = {
              add = "gsa";
              delete = "gsd";
              find = "gsf";
              find_left = "gsF";
              highlight = "gsh";
              replace = "gsr";
              update_n_lines = "gsn";
            };
          };
        };
      };

      markdown-preview.enable = true;
    };
  };
}
