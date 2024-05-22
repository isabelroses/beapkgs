{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
in
{
  options.programs.bellado = {
    enable = mkEnableOption "A fast and once simple cli todo tool";

    enableAliases = mkEnableOption "recommended bellado aliases";
  };

  config =
    let
      cfg = config.programs.bellado;

      aliases = optionalAttrs cfg.enableAliases {
        bel = "bellado";
        bell = "bellado -l";
        bella = "bellado -la";
        bellc = "bellado -lc";
      };
    in
    mkIf cfg.enable {
      home.packages = [ pkgs.bellado ];

      programs = {
        bash.shellAliases = aliases;
        zsh.shellAliases = aliases;
        fish.shellAliases = aliases;
        ion.shellAliases = aliases;
        nushell.shellAliases = aliases;
      };
    };
}
