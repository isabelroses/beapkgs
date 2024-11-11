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

      extLib = import ./ci.nix;

      forAllSystems =
        function:
        nixpkgs.lib.genAttrs lib.systems.flakeExposed (
          system:
          function (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            }
          )
        );

      packages = forAllSystems (
        pkgs:
        lib.packagesFromDirectoryRecursive {
          directory = ./pkgs;
          callPackage = lib.callPackageWith (
            pkgs // { pins = pkgs.callPackage ./_sources/generated.nix { }; }
          );
        }
      );
    in
    {
      inherit packages;
      legacyPackages = packages;

      githubActions = extLib.mkGithubMatrix {
        packages = {
          inherit (self.packages) x86_64-linux x86_64-darwin aarch64-darwin;
        };
      };

      devShells = forAllSystems (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      overlays.default = _: prev: self.packages.${prev.stdenv.hostPlatform.system} or { };

      # try getting default to merge modules using [lib.mergeModules](https://noogle.dev/f/lib/mergeModules)
      nixosModules.default = import ./modules/nixos;
      darwinModules.default = import ./modules/darwin self;
      homeManagerModules.default = import ./modules/home-manager self;
    };

  nixConfig = {
    extra-substituters = [ "https://isabelroses.cachix.org" ];
    extra-trusted-public-keys = [
      "isabelroses.cachix.org-1:mXdV/CMcPDaiTmkQ7/4+MzChpOe6Cb97njKmBQQmLPM="
    ];
  };
}
