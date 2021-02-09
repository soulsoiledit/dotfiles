{ pkgs, ... }:

{
  home.packages = with pkgs; [
    acpi
    dunst

    (pkgs.writeShellScriptBin "bar" (lib.readFile ./bar.sh))
  ];
}
