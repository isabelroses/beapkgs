# modified from https://github.com/nekowinston/nur/blob/49cfefd3c252f4c56725df01f817d1a8b93447d8/docs/default.nix
{ lib, pkgs, ... }:
let
  inherit (lib)
    mkForce
    filterAttrs
    scrubDerivations
    removePrefix
    ;

  mkEval =
    module:
    lib.evalModules {
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

  gitHubDeclaration = user: repo: subpath: {
    url = "https://github.com/${user}/${repo}/blob/main/${subpath}";
    name = subpath;
  };

  mkDoc =
    name: options:
    let
      doc = pkgs.nixosOptionsDoc {
        options = filterAttrs (n: _: n != "_module") options;
        documentType = "none";
        transformOptions =
          opt:
          opt
          // {
            declarations = map (
              decl:
              if lib.hasPrefix (toString ../.) (toString decl) then
                gitHubDeclaration "isabelroses" "beapkgs" (
                  removePrefix "/" (removePrefix (toString ../.) (toString decl))
                )
              else
                decl
            ) opt.declarations;
          };
      };
    in
    pkgs.runCommand "${name}-module-doc.md" { } ''
      cat >$out <<EOF
      # ${name} module options
      EOF

      cat ${doc.optionsCommonMark} >> $out
    '';

  pkgs-list = pkgs.runCommand "package-list.md" { } ''
    cat >$out <<EOF
    # package list
    EOF

    ${lib.getExe pkgs.jq} "keys[]" ${../_sources/generated.json} | tr -d \" >> $out
  '';

  convert =
    md:
    pkgs.runCommand "beapkgs.html"
      {
        nativeBuildInputs = with pkgs; [
          pandoc
          texinfo
        ];
      }
      ''
        mkdir $out

        pandoc \
          --from markdown \
          --to texinfo \
          -o file.texi \
          ${builtins.concatStringsSep " " md}

        sed -i "s/@top Top/@top isabelroses' modules/" file.texi

        texi2any ./file.texi \
          --html \
          --split=chapter \
          --css-include=${./pandoc.css} \
          --document-language=en \
          -o $out

        substituteInPlace $out/index.html --replace-quiet "Top (beapkgs&rsquo; modules)" "beapkgs&rsquo; modules"
      '';

  modulesPath = ../modules;

  nixosEval = mkEval (import (modulesPath + /nixos));
  darwinEval = mkEval (import (modulesPath + /darwin));
  hmEval = mkEval (import (modulesPath + /home-manager));

  nixos = mkDoc "nixos" nixosEval.options;
  darwin = mkDoc "darwin" darwinEval.options;
  hm = mkDoc "home-manager" hmEval.options;
in
{
  html = convert [
    pkgs-list
    nixos
    darwin
    hm
  ];

  md = pkgs.linkFarm "md" [
    {
      name = "nixos";
      path = modulesPath + /nixos;
    }
    {
      name = "darwin";
      path = modulesPath + /darwin;
    }
    {
      name = "home-manager";
      path = modulesPath + /home-manager;
    }
  ];
}
