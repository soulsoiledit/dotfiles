{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp.servers.hls = {
        enable = true;
        installGhc = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      haskell-tools-nvim
      telescope_hoogle
      haskell-snippets-nvim
    ];
  };
}
