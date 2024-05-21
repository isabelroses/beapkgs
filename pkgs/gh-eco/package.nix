{
  lib,
  pins,
  buildGoModule,
}:
let
  version = builtins.substring 0 7 pins.gh-eco.revision;
in
buildGoModule {
  pname = "gh-eco";
  inherit version;

  src = pins.gh-eco;

  vendorHash = "sha256-O3FQ+Z3KVYgTafwVXUhrGRuOAWlWlOhtVegKVoZBnDE=";

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
  ];

  meta = {
    description = "a working fork of gh-eco";
    homepage = "https://github.com/isabelroses/gh-eco";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
  };
}
