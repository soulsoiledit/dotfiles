{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.lib.stylix) colors;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};

  bg = colors.base00;
  layer = colors.base01;
  sel = colors.base02;
  gray = colors.base04;
  fg = colors.base05;

  accent = config.accent;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;

    colorScheme = lib.mkForce "custom";
    customColorScheme = {
      main = bg;
      sidebar = bg;
      player = bg;
      shadow = bg;

      main-elevated = layer;
      card = layer;
      button-disabled = layer;

      selected-row = sel;
      highlight = sel;
      highlight-elevated = sel;

      tab-active = gray;

      text = fg;
      subtext = gray;

      button = accent;
      button-active = accent;

      notification = accent;
      notification-error = colors.red;
      misc = accent;
    };

    enabledExtensions = builtins.attrValues {
      inherit (spicePkgs.extensions)
        adblock
        keyboardShortcut
        ;
    };
  };
}
