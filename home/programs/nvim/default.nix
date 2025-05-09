{
  config,
  inputs,
  pkgs,
  ...
}:

with config.lib.file;
with inputs.self.lib;
let
  flake = config.programs.nh.flake;
in
{
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile = {
    "nvim".source = mkOutOfStoreSymlink (relative flake ./.);
    "generated/nvim.lua".text =
      with config.lib.stylix.colors.withHashtag;
      # lua
      ''
        FLAKE = "${flake}"
        jdtls_dir = "${config.xdg.cacheHome}/jdtls"
        biome_config = "${config.xdg.configHome}/biome.json"
        blink_rg_dictionary = "${pkgs.scowl}/share/dict/wamerican.txt"
        mini_base16_palette = {
          base00 = "${base00}",
          base01 = "${base01}",
          base02 = "${base02}",
          base03 = "${base03}",
          base04 = "${base04}",
          base05 = "${base05}",
          base06 = "${base06}",
          base07 = "${base07}",
          base08 = "${base08}",
          base09 = "${base09}",
          base0A = "${base0A}",
          base0B = "${base0B}",
          base0C = "${base0C}",
          base0D = "${base0D}",
          base0E = "${base0E}",
          base0F = "${base0F}",
        }
      '';
  };
}
