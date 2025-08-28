{
  config,
  pkgs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile = {
    "nvim".source = config.lib.file.mkOutOfStoreSymlink (config.flake + "/home/programs/nvim");

    "biome/config.json".text = builtins.toJSON {
      formatter.indentStyle = "space";
    };
  };

  xdg.dataFile."dict/words".source = "${pkgs.scowl}/share/dict/wamerican.txt";

  home.sessionVariables.MANPAGER = "nvim +Man!";
}
