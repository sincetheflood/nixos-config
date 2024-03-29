{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

    nixosConfigurations = {
      ruby = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts
          ./hosts/ruby
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lynn = import hosts/ruby/home.nix;
          }
        ];
      };
      pyrrha = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts
          ./hosts/pyrrha
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lynn = import hosts/pyrrha/home.nix;
          }
        ];
      };
    };
  };
}
