let
  inherit (builtins) mapAttrs elem;
  # flatten = list: builtins.foldl' (acc: v: acc ++ v) [ ] list;

  self = {
    mkGithubMatrix =
      { packages }:
      mapAttrs (
        system: pkgs:
        mapAttrs (
          _: pkg:
          if
            (
              !(pkg.meta.broken or false)
              && (if pkg.meta ? platforms then (elem system pkg.meta.platforms) else true)
            )
          then
            pkg
          else
            null
        ) pkgs
      ) packages;
  };
in
self
