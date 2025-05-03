{
  description = "soil's nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # latest.url = "github:NixOS/nixpkgs";

    home-manager = {
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

    nix-index-database = {
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

    drg-mint.url = "github:trumank/mint";
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        # latestPackages = inputs.latest.legacyPackages.${system};
        drg-mint = inputs.drg-mint.packages.${system}.default;
        xwayland-satellite = inputs.niri.packages.${system}.xwayland-satellite-unstable;
      };
      pkgs = (nixpkgs.legacyPackages.${system}).extend overlay;
    in
    {
      lib = import ./lib inputs;

      formatter.${system} = pkgs.nixfmt-rfc-style;

      nixosConfigurations = {
        zephyrus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/zephyrus ];
        };
      };

      homeConfigurations = {
        soil = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = inputs.self.lib.autoimport ./home;
        };
      };
    };
}
