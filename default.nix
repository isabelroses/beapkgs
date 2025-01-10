{
  pkgs ? import <nixpkgs> {
    inherit system;
    overlays = [ ];
    config.allowUnfree = true;
  },
  lib ? pkgs.lib,
  system ? builtins.currentSystem,
}:
let
  packages = lib.packagesFromDirectoryRecursive {
    directory = ./pkgs;
    callPackage = lib.callPackageWith (pkgs // packages);
  };
in
packages
