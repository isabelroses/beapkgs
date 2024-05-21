{ self }:
let
  inherit (self.lib) mkModules;
  modules = mkModules ./.;
in
modules
