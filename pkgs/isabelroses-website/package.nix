{
  lib,
  pins,
  buildGoModule,
}:
let
  version = builtins.substring 0 7 pins.isabelroses-website.version;
in
buildGoModule {
  pname = "isabelroses-website";
  inherit version;

  inherit (pins.isabelroses-website) src;

  vendorHash = "sha256-9ZjF2Y5xx0+NARkh1zbTb4igYbCDEGDIMBxJWXOeGvc=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "isabelroses.com";
    homepage = "https://isabelroses.com/";
    license = with lib.licenses; [
      mit
      cc-by-nc-sa-40
    ];
    mainProgram = "isabelroses.com";
  };
}
