{
  lib,
  pkgs,
  nixosOptionsDoc,
  nuscht-search,
  ...
}:
let
  inherit (lib)
    evalModules
    scrubDerivations
    mkForce
    filterAttrs
    ;

  mkEval =
    module:
    evalModules {
      modules = [
        module
        {
          _module = {
            pkgs = mkForce (scrubDerivations "pkgs" pkgs);
            check = false;
          };
        }
      ];

      specialArgs = {
        inherit pkgs;
      };
    };

  mkDoc =
    options:
    let
      doc = nixosOptionsDoc {
        options = filterAttrs (n: _: n != "_module") options;
        documentType = "none";
      };
    in
    "${doc.optionsJSON}/share/doc/nixos/options.json";

  modulesPath = ../modules;
  nixosEval = mkEval (import (modulesPath + /nixos));
  darwinEval = mkEval (import (modulesPath + /darwin));
  hmEval = mkEval (import (modulesPath + /home-manager));

  nixos = mkDoc nixosEval.options;
  darwin = mkDoc darwinEval.options;
  hm = mkDoc hmEval.options;

  urlPrefix = "https://github.com/isabelroses/beapkgs/blob/main/";
in
nuscht-search.mkMultiSearch {
  title = "beapkgs Option Search";
  baseHref = "/";

  scopes = [
    {
      name = "NixOS modules";
      optionsJSON = nixos;
      inherit urlPrefix;
    }
    {
      name = "darwin modules";
      optionsJSON = darwin;
      inherit urlPrefix;
    }
    {
      name = "home-manager modules";
      optionsJSON = hm;
      inherit urlPrefix;
    }
  ];
}
