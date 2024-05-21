{ lib, self }:
let
  inherit (self.lib) mkModules;
  modules = mkModules ./.;
in
lib.attrsets.mapAttrs (_: mod: import mod self) modules
