{ pkgs, ... }:

{
  programs.nixvim = {
    # for bashls
    extraPackages = with pkgs; [ shfmt ];

    plugins = {
      lsp-format.enable = true;

      none-ls = {
        enable = true;
        sources.formatting.prettier.enable = true;
      };
    };
  };
}
