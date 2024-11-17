{
  lib,
  pkgs,
}:
let
  # nurPkgs =
  #   builtins.mapAttrs
  #     (name: content: pkgs.buildGoModule ({ inherit (pins.${name}) pname version src; } // content))
  #     {
  #       go-enum = {
  #         vendorHash = "sha256-YzIVI+PLZt24s/KjTxifWrvjrIU8jLvkC1lgw4yG6cg=";
  #         meta = {
  #           description = "An enum generator for go";
  #           homepage = "https://github.com/abice/go-enum";
  #           license = lib.licenses.mit;
  #           platforms = lib.platforms.unix;
  #         };
  #       };
  #       gomvp = {
  #         vendorHash = null;
  #         meta = {
  #           description = "gomvp lets you refactor/rename packages";
  #           homepage = "https://github.com/abenz1267/gomvp";
  #           license = lib.licenses.mit;
  #           platforms = lib.platforms.unix;
  #         };
  #       };
  #       json-to-struct = {
  #         vendorHash = "sha256-XeqElLWCHqQxWNrbFGB9nBekG9uWDmv1AkGIoHfX1Co=";
  #         meta = {
  #           description = "A simple command-line tool for generating to struct definitions from JSON";
  #           homepage = "https://github.com/tmc/json-to-struct";
  #           license = lib.licenses.gpl3;
  #           platforms = lib.platforms.unix;
  #         };
  #       };
  #     };

  paths = with pkgs; [
    # comments are binaries provided by the package
    # see https://github.com/ray-x/go.nvim/blob/master/lua/go/install.lua
    # all sorted in order of what they are in the file above, with this exception:
    gotools # callgraph, goimports, gorename, gonew (and guru though support has been removed)

    gofumpt
    golines
    golangci-lint
    gomodifytags
    gopls
    gotests
    iferr
    impl
    reftools # fillstruct, fillswitch
    delve # dlv
    ginkgo
    richgo
    gotestsum
    mockgen
    nurPkgs.json-to-struct
    nurPkgs.gomvp
    govulncheck
    nurPkgs.go-enum
  ];
in
pkgs.symlinkJoin {
  name = "gonvim-tools";

  inherit paths;

  meta = {
    description = "Convienience package for ray-x/go.nvim, that provides all external tools it relies on.";
    license = lib.lists.unique (
      lib.lists.flatten (builtins.map (pkg: pkg.meta.license or lib.licenses.unfree) paths)
    );
    platforms = lib.platforms.unix;
  };
}
