self:
{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.nh;
in
{
  options.programs.nh = {
    enable = lib.mkEnableOption "nh-darwin, yet another Nix CLI helper. Works on NixOS, NixDarwin, and HomeManager Standalone";

    package = lib.mkPackageOption pkgs "nh" { } // {
      default = self.packages.${pkgs.stdenv.hostPlatform.system}.nh-darwin;
    };

    flake = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = ''
        The path that will be used for the `FLAKE` environment variable.

        `FLAKE` is used by nh-darwin as the default flake for performing actions, like `nh-darwin os switch`.
      '';
    };

    clean = {
      enable = lib.mkEnableOption "periodic garbage collection with nh-darwin clean all";

      # Not in NixOS module
      user = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "User that runs the garbage collector.";
      };

      dates = lib.mkOption {
        type = lib.types.attrs;
        default = {
          Weekday = 0;
        };
        description = ''
          How often cleanup is performed. Passed to launchd.StartCalendarInterval

          The format is described in
          {manpage}`crontab(5)`.
        '';
      };

      extraArgs = lib.mkOption {
        type = lib.types.singleLineStr;
        default = "";
        example = "--keep 5 --keep-since 3d";
        description = ''
          Options given to nh-darwin clean when the service is run automatically.

          See `nh-darwin clean all --help` for more information.
        '';
      };
    };
  };

  config = {
    warnings =
      if (!(cfg.clean.enable -> !config.nix.gc.automatic)) then
        [
          "programs.nh.clean.enable and nix.gc.automatic are both enabled. Please use one or the other to avoid conflict."
        ]
      else
        [ ];

    assertions = [
      # Not strictly required but probably a good assertion to have
      {
        assertion = cfg.clean.enable -> cfg.enable;
        message = "programs.nh.clean.enable requires programs.nh.enable";
      }

      {
        assertion = (cfg.flake != null) -> !(lib.hasSuffix ".nix" cfg.flake);
        message = "nh.flake must be a directory, not a nix file";
      }
    ];

    environment = lib.mkIf cfg.enable {
      systemPackages = [ cfg.package ];
      variables = lib.mkIf (cfg.flake != null) { FLAKE = cfg.flake; };
    };

    launchd = lib.mkIf cfg.clean.enable {
      daemons.nh-clean = {
        command = "exec ${lib.getExe cfg.package} clean all ${cfg.clean.extraArgs}";
        environment.NIX_REMOTE = lib.optionalString config.nix.useDaemon "daemon";
        serviceConfig = {
          RunAtLoad = false;
          StartCalendarInterval = [ cfg.clean.interval ];
          UserName = cfg.clean.user;
        };
      };
    };
  };
}
