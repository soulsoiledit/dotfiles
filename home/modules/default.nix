{ config, pkgs, lib, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./dunst.nix
    ./fish.nix
    ./gammastep.nix
    ./git.nix
    ./gtk.nix
    ./lf.nix
    ./neovim
    ./rofi.nix
    ./vars.nix
    ./xorg
    ./hyprland.nix
    inputs.spicetify-nix.homeManagerModule
  ];

  home.packages = with pkgs; [
    steam
    discord

    # modern unix
    gdu
    ripgrep
    fd
    bat
    exa
    # eww

    # minecraft
    prismlauncher
    cubiomes-viewer

    # qol tools
    brightnessctl
    acpi
    dunst
    playerctl
    pamixer
    (p7zip.override { enableUnfree = true; })

    trash-cli
    nix-tree
    xplr
  ];

  programs.spicetify = {
    enable = true;
    # theme = spicePkgs.themes.catppuccin-mocha;
    # colorScheme = "green";
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      autoSkipVideo
      shuffle

      adblock
      hidePodcasts
      songStats
    ];
  };

  fonts.fontconfig.enable = true;
  programs.imv.enable = true;

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
    # enable = true;
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

  xdg.configFile."awesome".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/modules/awesome;
  xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/modules/eww;
}
