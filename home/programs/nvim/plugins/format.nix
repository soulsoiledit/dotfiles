{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [
      nodePackages.prettier
      stylua
      shfmt

      google-java-format
      ormolu
      clang-tools
    ];

    # efm-lsp
    # none-ls
    plugins.conform-nvim = {
      enable = true;

      settings = {
        format_on_save = {
          lsp_fallback = true;
          timeout_ms = 500;
        };

        formatters_by_ft = {
          lua = [ "stylua" ];
          java = [ "google-java-format" ];
          haskell = [ "ormolu" ];
          sh = [ "shfmt" ];

          javascript = [ "prettier" ];
          javascriptreact = [ "prettier" ];
          typescript = [ "prettier" ];
          typescriptreact = [ "prettier" ];
          css = [ "prettier" ];
          scss = [ "prettier" ];
          html = [ "prettier" ];
          json = [ "prettier" ];
          yaml = [ "prettier" ];
        };
      };
    };
  };
}
