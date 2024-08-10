{
  lib,
  pins,
  buildGoModule,
}:
let
  version = builtins.substring 0 7 pins.zzz.version;
in
buildGoModule {
  pname = "zzz";
  inherit version;

  inherit (pins.zzz) src;

  vendorHash = "sha256-Iz5+jZs80wWlbQ6pw0/CQHy2gaFm9pT/LdipfW9Hg4o=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Code snippets in your terminal 🛌";
    mainProgram = "zzz";
    homepage = "https://github.com/isabelroses/zzz";
    license = lib.licenses.mit;
  };
}
