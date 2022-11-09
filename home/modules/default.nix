{ config, pkgs, lib, inputs, master, ... }:

{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./dunst.nix
    ./fish.nix
    ./gammastep.nix
    ./git.nix
    ./gtk.nix
    ./imv.nix
    ./lf.nix
    ./neovim
    ./rofi.nix
    ./vars.nix

    ./xorg
    #./wayland
  ];

  home.packages = with pkgs; [
    trash-cli
    nix-tree
    xplr
    usbutils
    pciutils

    # modern unix
    ncdu
    ripgrep
    fd
    bat
    exa

    spotify
    (pkgs.discord.override { nss = pkgs.nss_latest; })

    prismlauncher
    ferium
    cubiomes-viewer

    brightnessctl
    acpi
    dunst
    playerctl
    pamixer

    source-han-sans
    protonvpn-gui

    piper
    steam
  ];

  fonts.fontconfig.enable = true;

  services.playerctld.enable = true;
  programs.starship.enable = true;
  programs.firefox = {
    enable = true;
    profiles.soil = {
      settings = {
        "browser.bookmarks.showMobileBookmarks" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layout.css.devPixelsPerPx" = 2;
        "browser.urlbar.suggest.calculator" = true;
      };
    };
  };
  programs.fzf.enable = true;

  xdg.enable = true;
  xsession.enable = true;

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    gtk.enable = true;
  };

  services.udiskie.enable = true;
  services.flameshot.enable = true;

  programs.zathura = {
    enable = true;
    extraConfig = "include ${inputs.catppuccin-zathura+"/src/catppuccin-mocha"}";
  };

  programs.discocss = {
    enable = true;
    # discordPackage = pkgs.discord.override { nss = pkgs.nss_latest; };
    discordAlias = false;
    css = builtins.readFile inputs.catppuccin-discord;
  };

  programs.bottom.enable = true;

  xdg.configFile."btop/themes".source = inputs.catppuccin-btop;
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha.theme";
      vim_keys = true;

      proc_tree = true;
      proc_gradient = false;

      proc_filter_kernel = true;
    };
  };
}
