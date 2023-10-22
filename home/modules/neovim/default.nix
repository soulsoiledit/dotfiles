{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    withNodeJs = true;

    extraConfig = "";

    extraPackages = with pkgs; [
      patchelf
      gcc
      gnumake
      unzip
      cargo
    ];

    # plugins = with pkgs.vimPlugins; [
    #   # markdown-preview-nvim
    # ];
  };

  programs.lazygit.enable = true;
}
