{
  description = "soil's nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    vesktop-fix.url = "github:NixOS/nixpkgs/pull/476347/head";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      inherit (nixpkgs.lib.fileset) toList fileFilter;
      autoimport = path: toList (fileFilter (file: file.hasExt "nix") path);
    in
    {
      nixosConfigurations = {
        zephyrus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = autoimport ./system ++ [ ./hosts/zephyrus ];
        };
      };

      homeConfigurations = {
        soil = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = autoimport ./home;
        };
      };

      formatter = {
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      };
    };
}
