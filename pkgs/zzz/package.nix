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

  vendorHash = "sha256-PUxVEfmkUYZNKFefuWM5gaU8pdAPK8ZP1b5hx+Zj2GU=";

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
