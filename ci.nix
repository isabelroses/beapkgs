# 10000000% stolen (with small modifications) from
# https://github.com/nix-community/nix-github-actions
let
  inherit (builtins) attrValues mapAttrs attrNames;
  flatten = list: builtins.foldl' (acc: v: acc ++ v) [ ] list;

  self = {
    githubPlatforms = {
      "x86_64-linux" = "ubuntu-22.04";
      "x86_64-darwin" = "macos-12";
      "aarch64-darwin" = "macos-14";
    };

    # Return a GitHub Actions matrix from a package set shaped like
    # the Flake attribute packages/checks.
    mkGithubMatrix =
      {
        packages, # Takes an attrset shaped like { x86_64-linux = { hello = pkgs.hello; }; }
        attrPrefix ? "packages",
        platforms ? self.githubPlatforms,
      }:
      {
        inherit packages;
        matrix = {
          include = flatten (
            attrValues (
              mapAttrs (
                system: pkgs:
                builtins.map (attr: {
                  name = attr;
                  inherit system;
                  os =
                    let
                      os = platforms.${system};
                    in
                    if builtins.typeOf os == "list" then os else [ os ];
                  package =
                    if attrPrefix != "" then "${attrPrefix}.${system}.\"${attr}\"" else "${system}.\"${attr}\"";
                }) (attrNames pkgs)
              ) packages
            )
          );
        };
      };
  };
in
self
