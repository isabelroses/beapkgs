{
  lib,
  pins,
  pkgs,
}:
let
  nurPkgs =
    builtins.mapAttrs
      (name: content: pkgs.buildGoModule ({ inherit (pins.${name}) pname version src; } // content))
      {
        go-enum = {
          vendorHash = "sha256-YzIVI+PLZt24s/KjTxifWrvjrIU8jLvkC1lgw4yG6cg=";
          meta = {
            description = "An enum generator for go";
            homepage = "https://github.com/abice/go-enum";
            license = lib.licenses.mit;
            platforms = lib.platforms.unix;
          };
        };
        gomvp = {
          vendorHash = null;
          meta = {
            description = "gomvp lets you refactor/rename packages";
            homepage = "https://github.com/abenz1267/gomvp";
            license = lib.licenses.mit;
            platforms = lib.platforms.unix;
          };
        };
        json-to-struct = {
          vendorHash = "sha256-XeqElLWCHqQxWNrbFGB9nBekG9uWDmv1AkGIoHfX1Co=";
          meta = {
            description = "A simple command-line tool for generating to struct definitions from JSON";
            homepage = "https://github.com/tmc/json-to-struct";
            license = lib.licenses.gpl3;
            platforms = lib.platforms.unix;
          };
        };
      };
in
pkgs.symlinkJoin rec {
  name = "gonvim-tools";

  # comments are binaries provided by the package
  # see https://github.com/ray-x/go.nvim/blob/master/lua/go/install.lua
  paths =
    with pkgs;
    with nurPkgs;
    [
      delve # dlv
      ginkgo
      go-enum
      gofumpt
      golangci-lint
      golines
      gomodifytags
      gomvp
      gopls
      gotests
      gotestsum
      gotools # callgraph, goimports, gorename, guru
      govulncheck
      iferr
      impl
      json-to-struct
      mockgen
      reftools # fillstruct, fillswitch
      richgo
    ];

  meta = {
    description = "Convienience package for ray-x/go.nvim, that provides all external tools it relies on.";
    license = lib.lists.unique (
      lib.lists.flatten (builtins.map (pkg: pkg.meta.license or lib.licenses.unfree) paths)
    );
    platforms = lib.platforms.unix;
  };
}
