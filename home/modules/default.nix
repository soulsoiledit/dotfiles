{ config, pkgs, lib, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModule
    ./alacritty.nix
    ./direnv.nix
    # ./dunst.nix
    ./fish.nix
    ./gammastep.nix
    ./git.nix
    ./gtk.nix
    ./lf.nix
    ./neovim
    ./rofi.nix
    ./vars.nix
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    steam
    webcord-vencord

    # Minecraft
    prismlauncher
    cubiomes-viewer

    # Modern Unix replacements
    gdu
    fd

    xplr

    # Qol Tools
    brightnessctl
    acpi
    playerctl
    (p7zip.override { enableUnfree = true; })

    trash-cli
    nix-tree
    xdg-utils
  ];

  programs.nix-index.enable = true;

  programs.ripgrep.enable = true;
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "base16";
    };
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
    icons = true;
  };

  programs.xplr.enable = true;

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

  programs.firefox = {
    enable = true;
    profiles.soil = {
      settings = {
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.urlbar.suggest.calculator" = true;
      };
    };
  };

  home.pointerCursor = {
    size = 24;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    gtk.enable = true;
  };

  services.playerctld.enable = true;
  services.udiskie.enable = true;
  systemd.user.startServices = "sd-switch";

  programs.zathura = {
    enable = true;
    extraConfig = "include ${inputs.catppuccin-zathura+"/src/catppuccin-mocha"}";
  };

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
