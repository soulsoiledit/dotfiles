{ config, lib, ... }:

let
  inherit (config.home) username;
in
{
  stylix.targets.firefox = {
    profileNames = [ username ];
    colorTheme.enable = true;
  };

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    profiles.${username} = {
      settings."font.size.variable.x-western" = lib.mkForce 16;
      settings."font.size.monospace.x-western" = lib.mkForce 12;

      extensions.force = true;
      extensions.packages = lib.mkForce [ ];
      extensions.settings."FirefoxColor@mozilla.com".settings.theme.colors =
        let
          inherit (config) accent;
          inherit (config.lib.stylix) colors;

          bg = "base00";
          fg = "base05";

          mkColor = color: {
            r = colors."${color}-rgb-r";
            g = colors."${color}-rgb-g";
            b = colors."${color}-rgb-b";
          };
        in
        lib.mkForce {
          toolbar = mkColor bg;
          toolbar_text = mkColor accent;
          frame = mkColor bg;
          frame_inactive = mkColor bg;

          ntp_background = mkColor bg;
          ntp_text = mkColor fg;

          button_background_hover = mkColor "base01";
          button_background_active = mkColor "base02";
          icons = mkColor accent;
          icons_attention = mkColor accent;

          popup = mkColor bg;
          popup_text = mkColor fg;
          popup_border = mkColor bg;
          popup_highlight = mkColor accent;
          popup_highlight_text = mkColor bg;

          sidebar = mkColor bg;
          sidebar_text = mkColor fg;
          sidebar_border = mkColor bg;
          sidebar_highlight = mkColor "base01";
          sidebar_highlight_text = mkColor fg;

          tab_text = mkColor fg;
          tab_background_text = mkColor "base04";
          tab_selected = mkColor "base02";
          tab_line = mkColor "base02";
          tab_loading = mkColor accent;

          toolbar_field = mkColor "base01";
          toolbar_field_text = mkColor fg;
          toolbar_field_border = mkColor "base01";
          toolbar_field_focus = mkColor "base01";
          toolbar_field_text_focus = mkColor fg;
          toolbar_field_border_focus = mkColor "base01";
          toolbar_field_highlight = mkColor accent;
          toolbar_field_highlight_text = mkColor bg;
        };
    };
  };

  home.file.".mozilla/native-messaging-hosts".enable = false;
}
