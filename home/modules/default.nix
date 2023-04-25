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
    # (spotify.override { deviceScaleFactor = 2; })
    spotify
    /* steam */

    # modern unix
    gdu
    ripgrep
    fd
    bat
    exa

    # minecraft
    # prismlauncher with higher gui scaling
    (pkgs.symlinkJoin {
      name = "prismlauncher";
      paths = [ pkgs.prismlauncher ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = '' wrapProgram $out/bin/prismlauncher --set QT_SCALE_FACTOR 2 '';
    })
    cubiomes-viewer

    # qol tools
    brightnessctl
    acpi
    dunst
    playerctl
    pamixer
    ( p7zip.override { enableUnfree = true; } )

    trash-cli
    nix-tree
    xplr

    xmonad-with-packages
    haskellPackages.xmonad-contrib
  ];

  fonts.fontconfig.enable = true;

  programs.starship.enable = true;
  programs.firefox = {
    enable = true;
    profiles.soil = {
      settings = {
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.urlbar.suggest.calculator" = true;
        # "layout.css.devPixelsPerPx" = 2;
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

  xdg.configFile."btop/themes".source = "${inputs.catppuccin-btop}/themes";

  xdg.enable = true;
  xsession.enable = true;
}
