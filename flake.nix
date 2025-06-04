{
  description = "soil's nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # latest.url = "github:NixOS/nixpkgs";

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    compress-yazi = {
      url = "github:Ev357/compress.yazi";
      flake = false;
    };

    drg-mint.url = "github:trumank/mint/7d399fc311752617dfa3eb21ee7d856a1f804517";

    topiary-yuck = {
      url = "github:dod-101/topiary-yuck";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, hm, ... }@inputs:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        # latestPackages = inputs.latest.legacyPackages.${system};
        drg-mint = inputs.drg-mint.packages.${system}.default;
        xwayland-satellite = inputs.niri.packages.${system}.xwayland-satellite-unstable;
        topiary-yuck = inputs.topiary-yuck.packages.${system}.default;
      };
      pkgs = (nixpkgs.legacyPackages.${system}).extend overlay;


      autoimport = with pkgs.lib.fileset; path: toList (fileFilter (file: file.hasExt "nix") path);
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;

      nixosConfigurations = {
        zephyrus = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = { inherit inputs; };
          modules = autoimport ./system ++ [ ./hosts/zephyrus ];
        };
      };

      homeConfigurations = {
        soil = hm.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = autoimport ./home;
        };
      };
    };
}
