{ config, ... }:

let
  getDesktop' = pkg: name: "${pkg}/share/applications/${name}.desktop";
  getDesktop = pkg: getDesktop' pkg (pkg.pname or pkg.name);
in
{
  xdg.autostart = {
    enable = true;
    entries = map getDesktop [
      config.programs.firefox.finalPackage
      config.programs.vesktop.package
    ];
  };
}
