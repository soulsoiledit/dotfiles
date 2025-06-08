{
  config,
  lib,
  pkgs,
  ...
}:

{
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile = {
    "nvim".source = config.lib.file.mkOutOfStoreSymlink (config.flake + "/home/programs/nvim");
    "generated/nvim.lua".text =
      # lua
      ''
        USER = "${config.home.username}"
        FLAKE = "${config.flake}"
        jdtls_dir = "${config.xdg.cacheHome}/jdtls"
        biome_config = "${
          pkgs.writers.writeJSON "biome.json" {
            formatter.indentStyle = "space";
          }
        }"
        blink_rg_dictionary = "${pkgs.scowl}/share/dict/wamerican.txt"
        mini_base16_palette = {
          ${lib.concatMapAttrsStringSep ",\n  " (
            key: value: ''${key} = "${value}"''
          ) config.stylix.base16Scheme}
        }
      '';
  };
}
