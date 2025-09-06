{ config, pkgs, ... }:

let
  getDesktop' = pkg: name: "${pkg}/share/applications/${name}.desktop";
  getDesktop = pkg: getDesktop' pkg (if pkg ? pname then pkg.pname else pkg.name);
in
{
  xdg.autostart = {
    enable = true;
    entries = map getDesktop [
      config.programs.firefox.finalPackage
      # config.programs.vesktop.package
      # pkgs.steam
    ];
  };
}
