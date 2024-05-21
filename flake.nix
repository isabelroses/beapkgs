{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # this will be used at some point for the modules
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # flake only users can ignore this input
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, ... }:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ] (system: function nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      packages = forAllSystems (
        pkgs:
        let
          inherit (nixpkgs) lib;
        in
        lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith (pkgs // { pins = import ./npins; });
          directory = ./pkgs;
        }
      );

      # maybe we can sneek in [lib.mergeModules](https://noogle.dev/f/lib/mergeModules) here
      # but to do that I would like to make something like packagesFromDirectoryRecursive
      homeManagerModules.default = import ./modules/home-manager;
      nixosModules.default = import ./modules/nixos;
      darwinModules.default = import ./modules/darwin;
    };
}
