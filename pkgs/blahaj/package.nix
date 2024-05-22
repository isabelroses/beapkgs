{ pins, buildNpmPackage }:
buildNpmPackage {
  pname = "blahaj";
  version = builtins.substring 0 7 pins.blahaj.revision;

  src = pins.blahaj;

  dontNpmBuild = true;

  npmDepsHash = "sha256-hjExjokjK3HZssWOkARDJY1m0+SxsQsxT2WaoBYqqe8=";
}
