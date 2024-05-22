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

      devShells = forAllSystems (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });

      overlays.default =
        final: _:
        lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith (final // { pins = import ./npins; });
          directory = ./pkgs;
        };

      packages = forAllSystems (
        pkgs:
        let
          docs = pkgs.callPackage ./docs { inherit self; };
        in
        {
          docs-md = docs.md;
          docs-html = docs.html;
        }
        // lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith (pkgs // { pins = import ./npins; });
          directory = ./pkgs;
        }
      );

      # try getting default to merge modules using [lib.mergeModules](https://noogle.dev/f/lib/mergeModules)
      nixosModules.default = import ./modules/nixos;
      darwinModules.default = import ./modules/darwin;
      homeManagerModules.default = import ./modules/home-manager;
    };
}
