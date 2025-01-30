{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, darwin, nixpkgs }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .

    # Configurations per system. The name should match the hostname
    darwinConfigurations = {
      "Balthild-Mac" = darwin.lib.darwinSystem {
        modules = [ ./darwin.nix ];
      }
    };
  };
}
