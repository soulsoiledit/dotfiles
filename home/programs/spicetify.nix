{
  config,
  inputs,
  pkgs,
  ...
}:

let
  inherit (config.lib.stylix.colors)
    base00
    base01
    base02
    base04
    base05

    red
    brown
    ;
  inherit (config) accent;

  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;

    colorScheme = "custom";
    customColorScheme = {
      main = base00;
      sidebar = base00;
      player = base00;

      text = base05;
      subtext = base04;

      main-elevated = base01;
      highlight = base01;
      card = base01;

      selected-row = base04;
      highlight-elevated = base02;
      tab-active = base02;
      shadow = base00;

      button = accent;
      button-active = accent;
      button-disabled = base02;

      notification = accent;
      notification-error = red;

      misc = brown;
    };

    enabledExtensions = [ spicePkgs.extensions.adblock ];
  };
}
