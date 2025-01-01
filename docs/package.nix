{
  pkgs,
  nuscht-search,
  ...
}:
let
  urlPrefix = "https://github.com/isabelroses/beapkgs/blob/main/";
in
nuscht-search.mkMultiSearch {
  title = "beapkgs Option Search";
  baseHref = "/";

  scopes = [
    {
      name = "NixOS modules";
      modules = [
        ../modules/nixos
        { _module.args = { inherit pkgs; }; }
      ];
      inherit urlPrefix;
    }
    {
      name = "darwin modules";
      modules = [
        ../modules/darwin
        { _module.args = { inherit pkgs; }; }
      ];
      inherit urlPrefix;
    }
    {
      name = "home-manager modules";
      modules = [
        ../modules/home-manager
        { _module.args = { inherit pkgs; }; }
      ];
      inherit urlPrefix;
    }
  ];
}
