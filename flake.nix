{
  inputs = rec {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    master.url = "github:nixos/nixpkgs";

    nixpkgs = unstable;

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spotify-adblock = {
      url = "github:fufexan/dotfiles/c7cffa0be4d3a96e463ea1f2a896543ecd27042d";
      inputs.nixpkgs.follows = "unstable";
    };

    catppuccin-discord = {
      url = "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css";
      flake = false;
    };

    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };

    catppuccin-zathura = {
      url = "github:catppuccin/zathura";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.soilnix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./system/configuration.nix
        {
          nix.registry.nixpkgs.flake = nixpkgs;
        }
      ];
      specialArgs = { inherit inputs; };
    };

    homeConfigurations.soil = home-manager.lib.homeManagerConfiguration
      {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home/home.nix
          {
            nixpkgs.overlays = [
              (final: prev: {
                # spotify = inputs.spotify-adblock.packages.x86_64-linux.orchis-theme;
              })
            ];
          }
        ];
        extraSpecialArgs = { inherit inputs; };
      };
  };
}
