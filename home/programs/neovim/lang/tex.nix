{ lib, pkgs, ... }:

{
  programs.nixvim.plugins = {
    lsp.servers.texlab = {
      enable = true;
      settings.texlab = {
        build = {
          executable = lib.getExe pkgs.tectonic;
          args = [
            "-X"
            "compile"
            "%f"
            "--synctex"
            "--keep-logs"
            "--keep-intermediates"
          ];

          onSave = true;
          forwardSearchAfter = true;
        };

        forwardSearch = {
          executable = lib.getExe pkgs.zathura;
          args = [
            "--synctex-forward"
            "%l:1:%f"
            "%p"
          ];
        };
      };
    };
  };
}
