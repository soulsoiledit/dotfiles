{
  config,
  inputs,
  pkgs,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  accent = config.opt.accent;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;

    customColorScheme = with config.lib.stylix.colors; {
      main = base00;
      sidebar = base00;
      player = base00;
      shadow = base00;

      main-elevated = base01;
      card = base01;
      button-disabled = base01;

      selected-row = base02;
      highlight = base02;
      highlight-elevated = base02;

      tab-active = base04;

      text = base05;
      subtext = base04;

      button = accent;
      button-active = accent;

      notification = accent;
      notification-error = base08;
      misc = accent;
    };

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      keyboardShortcut
    ];
  };
}
