{
  lib,
  pins,
  buildGoModule,
}:
let
  version = builtins.substring 0 7 pins.zzz.revision;
in
buildGoModule {
  pname = "zzz";
  inherit version;

  src = pins.zzz;

  vendorHash = "sha256-ePHkrsc9NJO8c3J1eDkFeSLvVs5flSeiTmXqkfF261s=";

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
