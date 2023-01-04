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
    spotify
    protonvpn-gui
    piper
    steam


    # modern unix
    ncdu
    ripgrep
    fd
    bat
    exa


    # minecraft
    prismlauncher
    ferium
    cubiomes-viewer

    # qol tools
    brightnessctl
    acpi
    dunst
    playerctl
    pamixer

    trash-cli
    nix-tree
    xplr

    # fixing discord fonts...
    source-han-sans
  ];

  fonts.fontconfig.enable = true;

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


  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    gtk.enable = true;
  };

  services.playerctld.enable = true;
  services.udiskie.enable = true;
  services.flameshot.enable = true;
  systemd.user.startServices = "legacy";

  programs.zathura = {
    enable = true;
    extraConfig = "include ${inputs.catppuccin-zathura+"/src/catppuccin-mocha"}";
  };

  programs.discocss = {
    enable = true;
    discordPackage = pkgs.discord.override { nss = pkgs.nss_latest; };
    discordAlias = true;
    css = builtins.readFile inputs.catppuccin-discord;
  };

  programs.bottom.enable = true;

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

  xdg.configFile."btop/themes".source = inputs.catppuccin-btop;

  xdg.enable = true;
  xsession.enable = true;

  xdg.desktopEntries."org.prismlauncher.PrismLauncher" = {
    name = "Prism Launcher";
    exec = "env QT_SCALE_FACTOR=2 prismlauncher";
    icon = "org.prismlauncher.PrismLauncher";
  };
}
