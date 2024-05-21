{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # flake only users can ignore this input
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;

      forAllSystems =
        function:
        lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ] (system: function nixpkgs.legacyPackages.${system});
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      lib = import ./lib { inherit lib; };

      devShells = forAllSystems (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });

      packages = forAllSystems (
        pkgs:
        lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith (pkgs // { pins = import ./npins; });
          directory = ./pkgs;
        }
      );

      # try getting default to merge modules using [lib.mergeModules](https://noogle.dev/f/lib/mergeModules)
      nixosModules = import ./modules/nixos { inherit self; };
      darwinModules = import ./modules/darwin { inherit self; };
      homeManagerModules = import ./modules/home-manager { inherit lib self; };
    };
}
