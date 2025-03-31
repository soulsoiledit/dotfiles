{ nixpkgs, ... }:

let
  lib = nixpkgs.lib;
in
{
  autoimport = path: lib.fileset.toList (lib.fileset.fileFilter (file: file.hasExt "nix") path);

  relative =
    flake: path: "${flake}/${lib.concatStringsSep "/" (lib.lists.drop 4 (lib.splitString "/" path))}";
}
