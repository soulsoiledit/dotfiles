{ pkgs, ... }:

{
  programs.nixvim.plugins = {
    lsp.servers = {
      html = {
        enable = true;
        extraOptions.init_options.provideFormatter = false;
      };

      cssls = {
        enable = true;
        extraOptions.init_options.provideFormatter = false;
      };

      vtsls = {
        enable = true;
        extraOptions.init_options.provideFormatter = false;
      };

      # format with biome
      biome = {
        enable = true;
        extraOptions.single_file_support = true;
        cmd = [
          "biome"
          "lsp-proxy"
          "--config-path"
          (toString (
            pkgs.writers.writeJSON "biome.json" {
              formatter.indentStyle = "space";
            }
          ))
        ];
      };
    };

    none-ls.sources.formatting.prettier = {
      enable = true;
      settings.filetypes = [
        "yaml"

        "markdown"
        "markdown.mdx"

        "html"
        "less"
        "scss"
      ];
    };
  };
}
