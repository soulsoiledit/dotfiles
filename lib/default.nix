{ nixpkgs, ... }:

let
  lib = nixpkgs.lib;
in
{
  autoimport = path: lib.fileset.toList (lib.fileset.fileFilter (file: file.hasExt "nix") path);
}
