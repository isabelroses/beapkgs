{ self }:
let
  inherit (self.lib) mkModules;
  modules = mkModules ./.;
in
{ default = builtins.throw "No default module is provided yet"; } // modules
