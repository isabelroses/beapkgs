{ beapkgsModules, beapkgsSelf }:
{ lib, config, ... }:
let
  inherit (lib) flip mkIf mkEnableOption;
  inherit (lib.modules) importApply;

  importApplySelf = map (flip importApply { beapkgs = beapkgsSelf; });
in
{
  options.beapkgs.cache.enable = mkEnableOption "beapkgs cache";

  imports = importApplySelf beapkgsModules;

  config = {
    nix.settings = mkIf config.beapkgs.cache.enable {
      substituters = [ "https://beapkgs.cachix.org" ];
      trusted-public-keys = [ "beapkgs.cachix.org-1:gcUFDNeQvGeAc/jDl/K8ax9WZvcCA71J+A36m7u7UWM=" ];
    };
  };
}
