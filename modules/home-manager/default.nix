{
  lib,
  pkgs,
  self,
  ...
}@args:
{
  imports = import ../lib args ./.;
}
