{
  lib,
  pkgs,
}:
let
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
    (callPackage ../json-to-struct/package.nix { })
    (callPackage ../gomvp/package.nix { })
    govulncheck
    (callPackage ../go-enum/package.nix { })
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
