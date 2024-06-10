{ pins, buildNpmPackage }:
buildNpmPackage {
  pname = "blahaj";
  version = builtins.substring 0 7 pins.blahaj.version;

  inherit (pins.blahaj) src;

  dontNpmBuild = true;

  npmDepsHash = "sha256-hjExjokjK3HZssWOkARDJY1m0+SxsQsxT2WaoBYqqe8=";
}
