{
  programs = {
    nixvim = {
      editorconfig.enable = true;

      plugins = {
        lsp-format.enable = true;

        none-ls = {
          enable = true;

          sources = {
            formatting = {
              shfmt.enable = true;
              prettier = {
                enable = true;
                disableTsServerFormatter = true;
              };
              google_java_format.enable = true;
              clang_format.enable = true;
            };

            code_actions = {
              proselint.enable = true;
              statix.enable = true;
            };

            completion = {
              spell.enable = true;
              tags.enable = true;
            };

            hover = {
              dictionary.enable = true;
              printenv.enable = true;
            };
          };
        };
      };
    };
  };
}
