{
  lib,
  pkgs,
  mkdocs,
  linkFarm,
  stdenvNoCC,
  runCommand,
  nixosOptionsDoc,
  python312Packages,
  ...
}:
let
  inherit (lib)
    evalModules
    scrubDerivations
    mkForce
    filterAttrs
    removePrefix
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

  gitHubDeclaration = user: repo: subpath: {
    url = "https://github.com/${user}/${repo}/blob/main/${subpath}";
    name = subpath;
  };

  mkDoc =
    name: options:
    let
      doc = nixosOptionsDoc {
        options = filterAttrs (n: _: n != "_module") options;
        documentType = "none";
        transformOptions =
          opt:
          opt
          // {
            declarations = map (
              decl:
              if lib.hasPrefix (toString ../../.) (toString decl) then
                gitHubDeclaration "isabelroses" "beapkgs" (
                  removePrefix "/" (removePrefix (toString ../../.) (toString decl))
                )
              else
                decl
            ) opt.declarations;
          };
      };
    in
    runCommand "${name}-module-doc.md" { } ''
      cat >$out <<EOF
      # ${name}
      EOF

      cat ${doc.optionsCommonMark} >> $out
    '';

  modules = linkFarm "modules" [
    {
      name = "nixos.md";
      path = nixos;
    }
    {
      name = "darwin.md";
      path = darwin;
    }
    {
      name = "home-manager.md";
      path = hm;
    }
  ];

  pkgs-list = runCommand "packages.md" { } ''
    cat >$out <<EOF
    # packages
    EOF

    ls ${../.} | sed 's/^/- /' >> $out
  '';

  modulesPath = ../../modules;

  nixosEval = mkEval (import (modulesPath + /nixos));
  darwinEval = mkEval (import (modulesPath + /darwin));
  hmEval = mkEval (import (modulesPath + /home-manager));

  nixos = mkDoc "nixos" nixosEval.options;
  darwin = mkDoc "darwin" darwinEval.options;
  hm = mkDoc "home-manager" hmEval.options;

  md = linkFarm "md" [
    {
      name = "index.md";
      path = ../../README.md;
    }
    {
      name = "modules";
      path = modules;
    }
    {
      name = "package.md";
      path = pkgs-list;
    }
  ];
in
stdenvNoCC.mkDerivation {
  pname = "beapkgs-docs";
  version = "0.2.0";

  src = md;

  nativeBuildInputs = [
    mkdocs
    python312Packages.pillow
    python312Packages.cairosvg
    python312Packages.mkdocs-material
  ];

  configurePhase = ''
    runHook preConfigure

    cp ${./mkdocs.yml} ./mkdocs.yml
    cp -R ${md} ./docs

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    mkdocs build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r site/* $out

    runHook postInstall
  '';

  meta = {
    description = "Beapkgs nix module options documentation";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}
