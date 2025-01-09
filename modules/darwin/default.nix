{ beapkgsSelf }:
{ lib, ... }:
{
  imports = [
    (lib.modules.importApply ../global.nix {
      beapkgsModules = import ./all-modules.nix;
      inherit beapkgsSelf;
    })
  ];
}
